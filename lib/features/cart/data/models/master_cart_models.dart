import 'package:equatable/equatable.dart';

class MasterCartModels extends Equatable {
  final String productId;
  final String name;
  final int price;
  final int quantity;
  final int subTotal;

  const MasterCartModels({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.subTotal,
  });

  @override
  List<Object?> get props => [productId, name, price, quantity, subTotal];
}
