import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';

class DeleteCartProduct {
  final CartRepository cartRepository;

  DeleteCartProduct({required this.cartRepository});

  Future<Either<Failure, String>> execute({required String productId}) {
    return cartRepository.deleteCartProduct(productId: productId);
  }
}
