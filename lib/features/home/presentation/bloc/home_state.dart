part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

final class ProductLoading extends HomeState {
  final CategoryEntities loadingPlaceholder;

  const ProductLoading({required this.loadingPlaceholder});

  @override
  List<Object> get props => [loadingPlaceholder];
}

final class ProductLoaded extends HomeState {
  final List<CategoryData> categoryEntities;
  final List<ProductData> productEntities;

  const ProductLoaded({
    required this.categoryEntities,
    required this.productEntities,
  });

  @override
  List<Object> get props => [productEntities];
}

final class ProductFailed extends HomeState {
  final String message;

  const ProductFailed({required this.message});

  @override
  List<Object> get props => [message];
}
