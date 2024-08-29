import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';

class AddProductToCart {
  final CartRepository cartRepository;

  AddProductToCart({required this.cartRepository});

  Future<Either<Failure, String>> execute({required CartBody cartBody}) {
    return cartRepository.addProductToCart(cartBody: cartBody);
  }
}
