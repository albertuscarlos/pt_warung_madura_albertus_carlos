import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';

class ProductModel {
  final List<ProductDataModel> products;

  ProductModel({required this.products});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: (json['data'] as List<dynamic>)
            .map((data) => ProductDataModel.fromJson(data))
            .toList(),
      );

  ProductEntities toEntities() => ProductEntities(
        products: products.map((data) => data.toEntities()).toList(),
      );
}

class ProductDataModel extends Equatable {
  final String id;
  final String categoryId;
  final String name;
  final int price;
  final String pictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductDataModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.pictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDataModel(
        id: json['id'],
        categoryId: json['category_id'],
        name: json['name'],
        price: json['price'],
        pictureUrl: json['picture_url'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  ProductData toEntities() => ProductData(
        id: id,
        categoryId: categoryId,
        name: name,
        price: price,
        pictureUrl: pictureUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

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
