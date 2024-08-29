import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/widgets/order_card_items.dart';

class OrderTotalCard extends StatelessWidget {
  final int total;
  const OrderTotalCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        child: ColoredBox(
          color: Style.secondaryColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                OrderCardItems(
                  title: 'Cart Total',
                  bodyTextColor: Style.primaryColor,
                  titleTextStyle: Style.poppinsFont.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                OrderCardItems(
                  title: 'Total',
                  bodyText: 'Rp. $total',
                  isLastRow: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
