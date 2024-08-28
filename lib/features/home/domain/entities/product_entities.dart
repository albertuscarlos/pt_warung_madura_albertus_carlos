import 'package:equatable/equatable.dart';

class ProductEntities extends Equatable {
  final List<ProductData> products;

  const ProductEntities({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductData extends Equatable {
  final String id;
  final String categoryId;
  final String name;
  final int price;
  final String pictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductData({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.pictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        name,
        price,
        pictureUrl,
        createdAt,
        updatedAt,
      ];
}
