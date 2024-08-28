import 'dart:io';

import 'package:equatable/equatable.dart';

class ProductBodyEntities extends Equatable {
  final File? productImage;
  final String? productName;
  final num? price;
  final String? category;

  const ProductBodyEntities({
    required this.productImage,
    required this.productName,
    required this.price,
    required this.category,
  });

  @override
  List<Object?> get props => [
        productImage,
        productName,
        price,
        category,
      ];
}
