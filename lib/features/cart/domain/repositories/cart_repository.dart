import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/update_cart_body.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartData>>> getCartProduct();
  Future<Either<Failure, String>> addProductToCart({
    required CartBody cartBody,
  });
  Future<Either<Failure, String>> updateCartProduct({
    required UpdateCartBody updateCartBody,
  });
  Future<Either<Failure, String>> deleteCartProduct({
    required String productId,
  });
  Future<Either<Failure, String>> deleteAllProduct();
}
