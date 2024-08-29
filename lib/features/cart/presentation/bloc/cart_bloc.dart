import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/core/constants/dummy_data.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/core/utils/app_enum.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/update_cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/delete_all_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/delete_cart_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/get_cart_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/update_cart_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddProductToCart addProductToCart;
  final GetCartProduct getCartProduct;
  final UpdateCartProduct updateCartProduct;
  final DeleteCartProduct deleteCartProduct;
  final DeleteAllProduct deleteAllProduct;
  CartBloc({
    required this.addProductToCart,
    required this.getCartProduct,
    required this.deleteCartProduct,
    required this.updateCartProduct,
    required this.deleteAllProduct,
  }) : super(CartInitial()) {
    on<AddProduct>((event, emit) async {
      emit(HomeCartLoading());

      await Future.delayed(const Duration(seconds: 1));

      final result = await getCartProduct.execute();

      await result.fold((failure) {
        emit(CartFailed(message: failure.message));
      }, (loaded) async {
        //if selected product already in cart
        final isInCart = loaded.any((elements) {
          return elements.productId == event.productData.id;
        });

        //if true update the quantity only
        if (isInCart) {
          UpdateCartBody? updateCartBody;
          for (var product in loaded) {
            updateCartBody = UpdateCartBody(
              productId: event.productData.id,
              quantity: product.quantity + 1,
              subTotal: product.price * (product.quantity + 1),
            );
          }

          final result =
              await updateCartProduct.execute(updateCartBody: updateCartBody!);

          result.fold((failed) {
            emit(CartFailed(message: failed.message));
          }, (success) {
            emit(CartSuccess(message: success));
          });

          //if false add product into cart
        } else {
          final cartBody = CartBody(
            productId: event.productData.id,
            name: event.productData.name,
            price: event.productData.price,
            quantity: 1,
            subTotal: event.productData.price,
          );

          final result = await addProductToCart.execute(cartBody: cartBody);

          result.fold((failed) {
            emit(CartFailed(message: failed.message));
          }, (success) {
            emit(CartSuccess(message: success));
          });
        }
      });
    });

    on<LoadCartProduct>((event, emit) async {
      emit(CartLoading(placeholder: DummyData.cartDataDummy));

      await Future.delayed(const Duration(seconds: 1));

      final result = await getCartProduct.execute();

      result.fold((failure) {
        emit(CartFailed(message: failure.message));
      }, (loaded) {
        //count all the subtotal
        final total = loaded.fold(0, (sum, item) => sum + item.subTotal);
        emit(CartLoaded(cartData: loaded, total: total));
      });
    });

    on<DeleteProductFromCart>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;

        final result = await deleteCartProduct.execute(
          productId: event.productId,
        );

        await result.fold((failure) {
          emit(CartFailed(message: failure.message));
        }, (success) async {
          //if delete success request the get cart
          final result = await getCartProduct.execute();

          result.fold((failure) {
            emit(CartFailed(message: failure.message));
          }, (loaded) {
            //count subtotal in each object
            final total = loaded.fold(0, (sum, item) => sum + item.subTotal);
            emit(currentState.copyWith(cartData: loaded, total: total));
          });
        });
      }
    });

    on<UpdateProductQuantity>((event, emit) async {
      if (state is CartLoaded) {
        //hold current state
        final currentState = state as CartLoaded;

        //hold event data
        final data = event.cartData;

        //declared for late usage inside the logic :)
        UpdateCartBody? updateCartBody;
        Either<Failure, String>? result;

        //if user tap decrease btn
        if (event.action == QuantityAction.decrease) {
          updateCartBody = UpdateCartBody(
            productId: data.productId,
            quantity: data.quantity - 1,
            subTotal: data.price * (data.quantity - 1),
          );

          //if cart qty below 1
          if ((data.quantity - 1) < 1) {
            result = await deleteCartProduct.execute(
              productId: data.productId,
            );
          } else {
            result = await updateCartProduct.execute(
              updateCartBody: updateCartBody,
            );
          }

          //if user tap increase btn
        } else {
          updateCartBody = UpdateCartBody(
            productId: data.productId,
            quantity: data.quantity + 1,
            subTotal: data.price * (data.quantity + 1),
          );
          result = await updateCartProduct.execute(
            updateCartBody: updateCartBody,
          );
        }

        //fold request adjust the logic above
        await result.fold((failed) {
          emit(CartFailed(message: failed.message));
        }, (success) async {
          //if update success request the cart data
          final result = await getCartProduct.execute();

          result.fold((failure) {
            emit(CartFailed(message: failure.message));
          }, (loaded) {
            //count all the subtotal in each object
            final total = loaded.fold(0, (sum, item) => sum + item.subTotal);
            emit(currentState.copyWith(cartData: loaded, total: total));
          });
        });
      }
    });
    on<PayBill>((event, emit) async {
      final result = await deleteAllProduct.execute();

      result.fold((failed) {
        emit(CartFailed(message: failed.message));
      }, (success) {
        emit(PayBillLoading());
      });
    });
  }
}
