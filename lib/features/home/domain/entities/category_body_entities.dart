import 'package:equatable/equatable.dart';

class CategoryBodyEntities extends Equatable {
  final String categoryName;

  const CategoryBodyEntities({required this.categoryName});

  Map<String, dynamic> toJson() => {
        'name': categoryName,
      };

  @override
  List<Object?> get props => [categoryName];
}
