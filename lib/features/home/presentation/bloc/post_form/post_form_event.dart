part of 'post_form_bloc.dart';

sealed class PostFormEvent extends Equatable {
  const PostFormEvent();

  @override
  List<Object> get props => [];
}

final class FillForm extends PostFormEvent {}

final class FillCategoryName extends PostFormEvent {
  final String categoryName;

  const FillCategoryName({
    required this.categoryName,
  });

  @override
  List<Object> get props => [
        categoryName,
      ];
}

final class FillProductImage extends PostFormEvent {
  final File productImage;

  const FillProductImage({
    required this.productImage,
  });

  @override
  List<Object> get props => [
        productImage,
      ];
}

final class FillProductName extends PostFormEvent {
  final String productName;

  const FillProductName({required this.productName});

  @override
  List<Object> get props => [productName];
}

final class FillProductPrice extends PostFormEvent {
  final String price;

  const FillProductPrice({required this.price});

  @override
  List<Object> get props => [price];
}

final class FillProductCategory extends PostFormEvent {
  final String category;
  final String categoryName;

  const FillProductCategory({
    required this.category,
    required this.categoryName,
  });

  @override
  List<Object> get props => [category, categoryName];
}

final class PostFilledCategory extends PostFormEvent {}

final class PostFilledProduct extends PostFormEvent {}

final class ClearState extends PostFormEvent {}
