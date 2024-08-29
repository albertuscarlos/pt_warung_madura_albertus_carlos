import 'package:equatable/equatable.dart';

class UpdateCartBody extends Equatable {
  final String productId;
  final int quantity;
  final int subTotal;

  const UpdateCartBody({
    required this.productId,
    required this.quantity,
    required this.subTotal,
  });

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'quantity': quantity,
        'sub_total': subTotal,
      };
  @override
  List<Object?> get props => [productId, quantity, subTotal];
}
