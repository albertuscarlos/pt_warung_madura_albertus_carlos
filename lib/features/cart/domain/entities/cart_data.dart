import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/master_cart_entities.dart';

class CartData extends MasterCartEntities {
  final int id;

  const CartData({
    required this.id,
    required super.productId,
    required super.name,
    required super.price,
    required super.quantity,
    required super.subTotal,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        name,
        price,
        quantity,
        subTotal,
      ];
}
