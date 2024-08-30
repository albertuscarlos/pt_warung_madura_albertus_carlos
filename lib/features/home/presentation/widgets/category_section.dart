import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/empty_product_card.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/product_card.dart';

class CategorySection extends StatelessWidget {
  final CategoryData categoryData;
  final List<ProductData>? products;
  const CategorySection({
    super.key,
    required this.categoryData,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryData.name,
          style: Style.buttonTextStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 7),
        if (products != null && products!.isNotEmpty)
          SizedBox(
            height: 360,
            child: ListView.separated(
              itemCount: products?.length ?? 0,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final listProduct = products;

                if (listProduct != null) {
                  final product = listProduct[index];
                  if (listProduct.isNotEmpty) {
                    return ProductCard(
                      product: product,
                    );
                  } else {
                    log('Emptyyy');
                  }
                }
                log('Emptyyy');
                return ProductCard(
                  product: ProductData(
                      id: '1',
                      categoryId: '',
                      name: 'Name',
                      price: 1,
                      pictureUrl: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now()),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          ),
        if (products == null || products!.isEmpty)
          EmptyProductCard(
            product: ProductData(
                id: '1',
                categoryId: '',
                name: 'Name',
                price: 1,
                pictureUrl: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now()),
          ),
      ],
    );
  }
}
