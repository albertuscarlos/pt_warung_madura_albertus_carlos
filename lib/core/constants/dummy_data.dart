import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';

class DummyData {
  static final categoryDummy = CategoryEntities(
    categories: List.generate(
      2,
      (index) {
        return CategoryData(
          id: '1',
          name: 'Minuman',
          createdAt: DateTime.now(),
          productByCategory: List.generate(
            2,
            (index) {
              return ProductData(
                id: '1',
                categoryId: '1',
                name: 'Thai Tea',
                price: 20000,
                pictureUrl:
                    'https://sakiproducts.com/cdn/shop/articles/20230310181037-thai-tea-recipe_1920x1080.webp?v=1678471844',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
            },
          ),
        );
      },
    ),
  );

  static final List<CartData> cartDataDummy = List.generate(
    1,
    (index) => const CartData(
      id: 1,
      productId: '1',
      name: 'Coconut',
      price: 10000,
      quantity: 1,
      subTotal: 10000,
    ),
  );
}
