import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/core/utils/app_enum.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/widgets/order_card_items.dart';

class OrderCard extends StatelessWidget {
  final CartData cartData;
  const OrderCard({super.key, required this.cartData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Style.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              OrderCardItems(
                showCloseButton: true,
                onPressed: () => context.read<CartBloc>().add(
                      DeleteProductFromCart(
                        productId: cartData.productId,
                      ),
                    ),
              ),
              OrderCardItems(
                title: 'PRODUCT',
                bodyText: cartData.name,
                bodyTextColor: Style.primaryColor,
              ),
              OrderCardItems(
                title: 'PRICE',
                bodyText: 'Rp. ${cartData.price}',
              ),
              OrderCardItems(
                title: 'QUANTITY',
                isShowCounter: true,
                quantity: cartData.quantity,
                onTapIncrease: () {
                  context.read<CartBloc>().add(
                        UpdateProductQuantity(
                          cartData: cartData,
                        ),
                      );
                },
                onTapDecrease: () {
                  context.read<CartBloc>().add(
                        UpdateProductQuantity(
                          cartData: cartData,
                          action: QuantityAction.decrease,
                        ),
                      );
                },
              ),
              OrderCardItems(
                title: 'SUBTOTAL',
                bodyText: 'Rp. ${cartData.subTotal}',
                isLastRow: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
