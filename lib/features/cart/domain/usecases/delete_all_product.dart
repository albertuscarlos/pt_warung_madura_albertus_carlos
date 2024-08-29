import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';

class DeleteAllProduct {
  final CartRepository cartRepository;

  DeleteAllProduct({required this.cartRepository});

  Future<Either<Failure, String>> execute() {
    return cartRepository.deleteAllProduct();
  }
}
