part of 'post_form_bloc.dart';

sealed class PostFormState extends Equatable {
  const PostFormState();

  @override
  List<Object> get props => [];
}

final class PostFormInitial extends PostFormState {}

final class PostFillForm extends PostFormState {
  final File? productImage;
  final String? productName;
  final num? price;
  final String? category;
  final String? categoryName;

  const PostFillForm({
    this.productImage,
    this.productName,
    this.price,
    this.category,
    this.categoryName,
  });

  PostFillForm copyWith({
    ProductBodyEntities? productBodyEntities,
    File? productImage,
    String? productName,
    num? price,
    String? category,
    String? categoryName,
  }) {
    return PostFillForm(
      productImage: productImage ?? this.productImage,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      category: category ?? this.category,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  List<Object> get props => [
        productImage ?? '',
        productName ?? '',
        price ?? '',
        category ?? '',
        categoryName ?? '',
      ];
}

final class PostFormLoading extends PostFormState {}

final class PostFormSuccess extends PostFormState {}

final class PostFormFailed extends PostFormState {
  final String message;

  const PostFormFailed({required this.message});

  @override
  List<Object> get props => [message];
}
