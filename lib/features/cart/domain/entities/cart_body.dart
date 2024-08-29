import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/master_cart_entities.dart';

class CartBody extends MasterCartEntities {
  const CartBody({
    required super.productId,
    required super.name,
    required super.price,
    required super.quantity,
    required super.subTotal,
  });

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'sub_total': subTotal,
      };
}
