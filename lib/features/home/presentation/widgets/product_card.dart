import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image(
              height: 165,
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(
                product.pictureUrl,
              ),
            ),
          ),
          Expanded(
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Style.rubikFont.copyWith(
                            fontSize: 15,
                            height: 1.428,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Style.deleteBtnColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Delete',
                            style: Style.rubikFont.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Style.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      'Rp. ${product.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Style.rubikFont.copyWith(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: CustomElevatedButton(
                      btnText: '+ Add to Cart',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
