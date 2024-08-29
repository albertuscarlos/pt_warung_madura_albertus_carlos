part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends ProductState {}

final class ProductLoading<T> extends ProductState {
  final T? loadingPlaceholder;

  const ProductLoading({this.loadingPlaceholder});

  @override
  List<Object> get props => [loadingPlaceholder ?? ''];
}

final class ProductLoaded<T> extends ProductState {
  final List<CategoryData> searchCategory;
  final List<CategoryData> categoryEntities;
  final List<ProductData> productEntities;

  const ProductLoaded({
    required this.searchCategory,
    required this.categoryEntities,
    required this.productEntities,
  });

  ProductLoaded copyWith({List<CategoryData>? categoryEntities}) {
    return ProductLoaded(
      searchCategory: searchCategory,
      categoryEntities: categoryEntities ?? this.categoryEntities,
      productEntities: productEntities,
    );
  }

  @override
  List<Object> get props => [productEntities, categoryEntities, searchCategory];
}

final class ProductDeleted<T> extends ProductState {
  final List<CategoryData> categoryEntities;
  final List<ProductData> productEntities;

  const ProductDeleted({
    required this.categoryEntities,
    required this.productEntities,
  });

  @override
  List<Object> get props => [productEntities];
}

final class ProductFailed<T> extends ProductState {
  final String message;
  final T? previousState;

  const ProductFailed({required this.message, this.previousState});

  ProductFailed<T> copyWith({T? previousState}) {
    return ProductFailed<T>(
      message: message,
      previousState: previousState ?? this.previousState,
    );
  }

  @override
  List<Object> get props => [message, previousState ?? ''];
}
