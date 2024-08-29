part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class LoadCategoryAndProduct extends ProductEvent {}

final class DeleteSelectedProduct extends ProductEvent {
  final String productId;

  const DeleteSelectedProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}

final class SearchProduct extends ProductEvent {
  final String searchKeyword;

  const SearchProduct({required this.searchKeyword});

  @override
  List<Object> get props => [searchKeyword];
}
