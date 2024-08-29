import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/update_cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartProduct {
  final CartRepository cartRepository;

  UpdateCartProduct({required this.cartRepository});

  Future<Either<Failure, String>> execute({
    required UpdateCartBody updateCartBody,
  }) {
    return cartRepository.updateCartProduct(updateCartBody: updateCartBody);
  }
}
