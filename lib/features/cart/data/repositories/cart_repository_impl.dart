import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/exceptions.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/update_cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDatasource cartLocalDatasource;

  CartRepositoryImpl({required this.cartLocalDatasource});

  @override
  Future<Either<Failure, String>> addProductToCart({
    required CartBody cartBody,
  }) async {
    try {
      final result = await cartLocalDatasource.addProductToCart(
        cartBody: cartBody,
      );
      return Right(result);
    } on DatabaseException {
      return const Left(
        DatabaseFailure('Something went wrong when add product to cart.'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> deleteCartProduct({
    required String productId,
  }) async {
    try {
      final result =
          await cartLocalDatasource.deleteCartProduct(productId: productId);
      return Right(result);
    } on DatabaseException {
      return const Left(
        DatabaseFailure(
          'Something went wrong when deleting product',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CartData>>> getCartProduct() async {
    try {
      final result = await cartLocalDatasource.getCartData();
      return Right(result.map((data) => data.toEntities()).toList());
    } on DatabaseException {
      return const Left(
        DatabaseFailure('Something went wrong when fetch product data.'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updateCartProduct({
    required UpdateCartBody updateCartBody,
  }) async {
    try {
      final result = await cartLocalDatasource.updateCartProduct(
          updateCartBody: updateCartBody);

      return Right(result);
    } on DatabaseException {
      return const Left(
        DatabaseFailure('Something went wrong when update product data.'),
      );
    }
  }
}
