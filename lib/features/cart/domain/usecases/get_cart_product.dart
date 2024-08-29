import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';

class GetCartProduct {
  final CartRepository cartRepository;

  GetCartProduct({required this.cartRepository});

  Future<Either<Failure, List<CartData>>> execute() {
    return cartRepository.getCartProduct();
  }
}
