import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';

class CategoryModel extends Equatable {
  final List<CategoryDataModel> categories;

  const CategoryModel({required this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: (json['data'] as List<dynamic>)
            .map((data) => CategoryDataModel.fromJson(data))
            .toList(),
      );

  CategoryEntities toEntities() => CategoryEntities(
        categories: categories.map((data) => data.toEntities()).toList(),
      );

  @override
  List<Object?> get props => [categories];
}

class CategoryDataModel extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;

  const CategoryDataModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        id: json['id'],
        name: json['name'],
        createdAt: DateTime.parse(
          json['created_at'],
        ),
      );

  CategoryData toEntities() => CategoryData(
        id: id,
        name: name,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
      ];
}
