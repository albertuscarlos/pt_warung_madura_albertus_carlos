import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';

class EmptyProductCard extends StatelessWidget {
  final ProductData product;
  const EmptyProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Style.secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Style.textFieldIconColor,
            spreadRadius: -3,
            blurRadius: 7,
            offset: Offset(3, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 15,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product still empty',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Style.rubikFont.copyWith(
                fontSize: 16,
                height: 1.25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Product in this Category is still empty',
              style: Style.rubikFont.copyWith(
                fontSize: 15,
                height: 1.428,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
