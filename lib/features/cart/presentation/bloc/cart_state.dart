part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class HomeCartLoading extends CartState {}

class CartLoading extends CartState {
  final List<CartData> placeholder;

  const CartLoading({required this.placeholder});

  @override
  List<Object> get props => [placeholder];
}

class CartFailed extends CartState {
  final String message;

  const CartFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class CartSuccess extends CartState {
  final String message;

  const CartSuccess({required this.message});
}

class CartLoaded extends CartState {
  final List<CartData> cartData;
  final int total;

  const CartLoaded({required this.cartData, required this.total});

  CartLoaded copyWith({List<CartData>? cartData, int? total}) => CartLoaded(
        cartData: cartData ?? this.cartData,
        total: total ?? this.total,
      );

  @override
  List<Object> get props => [cartData, total];
}
