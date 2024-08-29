import 'package:pt_warung_madura_albertus_carlos/features/cart/data/models/master_cart_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';

class CartDataModels extends MasterCartModels {
  final int id;
  const CartDataModels({
    required this.id,
    required super.productId,
    required super.name,
    required super.price,
    required super.quantity,
    required super.subTotal,
  });

  factory CartDataModels.fromJson(Map<String, dynamic> json) => CartDataModels(
        id: json['id'],
        productId: json['product_id'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
        subTotal: json['sub_total'],
      );

  CartData toEntities() => CartData(
        id: id,
        productId: productId,
        name: name,
        price: price,
        quantity: quantity,
        subTotal: subTotal,
      );

  @override
  List<Object?> get props => [id, productId, name, price, quantity, subTotal];
}
