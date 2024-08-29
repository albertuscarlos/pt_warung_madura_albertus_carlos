import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class EmptyCartPlaceholder extends StatelessWidget {
  const EmptyCartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          const Image(
            width: 100,
            image: AssetImage(
              'assets/images/empty_cart.png',
            ),
          ),
          const SizedBox(height: 39),
          const Text(
            'Cart still empty!\nStart shopping by click "Add to Cart" in Home',
            textAlign: TextAlign.center,
            style: Style.poppinsFont,
          )
        ],
      ),
    );
  }
}
