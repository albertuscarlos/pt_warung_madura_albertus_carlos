part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class AddProduct extends CartEvent {
  final ProductData productData;

  const AddProduct({required this.productData});

  @override
  List<Object> get props => [productData];
}

final class LoadCartProduct extends CartEvent {}

final class UpdateProduct extends CartEvent {
  final ProductData productData;

  const UpdateProduct({required this.productData});

  @override
  List<Object> get props => [productData];
}

final class DeleteProductFromCart extends CartEvent {
  final String productId;

  const DeleteProductFromCart({required this.productId});

  @override
  List<Object> get props => [productId];
}

final class UpdateProductQuantity extends CartEvent {
  final CartData cartData;
  final QuantityAction action;

  const UpdateProductQuantity({
    required this.cartData,
    this.action = QuantityAction.increase,
  });

  @override
  List<Object> get props => [cartData, action];
}
