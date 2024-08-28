import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';

class CategoryEntities extends Equatable {
  final List<CategoryData> categories;

  const CategoryEntities({
    required this.categories,
  });

  @override
  List<Object?> get props => [categories];
}

class CategoryData extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final List<ProductData>? productByCategory;

  const CategoryData({
    required this.id,
    required this.name,
    required this.createdAt,
    this.productByCategory,
  });

  CategoryData copyWith({List<ProductData>? productByCategory}) {
    return CategoryData(
      id: id,
      name: name,
      createdAt: createdAt,
      productByCategory: productByCategory ?? this.productByCategory,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt, productByCategory];
}
