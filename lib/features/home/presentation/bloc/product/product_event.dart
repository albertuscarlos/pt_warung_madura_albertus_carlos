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
