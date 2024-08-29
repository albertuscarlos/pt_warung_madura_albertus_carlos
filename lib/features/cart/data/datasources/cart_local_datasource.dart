import 'dart:developer';

import 'package:pt_warung_madura_albertus_carlos/core/error/exceptions.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/data/datasources/db/database_helper.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/data/models/cart_data_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_body.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/update_cart_body.dart';

abstract class CartLocalDatasource {
  Future<List<CartDataModels>> getCartData();
  Future<String> addProductToCart({required CartBody cartBody});
  Future<String> updateCartProduct({required UpdateCartBody updateCartBody});
  Future<String> deleteCartProduct({required String productId});
  Future<String> deleteAllProduct();
}

class CartLocalDatasourceImpl implements CartLocalDatasource {
  final DatabaseHelper databaseHelper;

  CartLocalDatasourceImpl({required this.databaseHelper});

  @override
  Future<String> addProductToCart({required CartBody cartBody}) async {
    try {
      await databaseHelper.addProductToCart(cartBody: cartBody);
      return 'Product added to cart';
    } catch (e) {
      throw DatabaseException('Something went wrong');
    }
  }

  @override
  Future<List<CartDataModels>> getCartData() async {
    try {
      final request = await databaseHelper.getCartProduct();
      return request
          .map((products) => CartDataModels.fromJson(products))
          .toList();
    } catch (e) {
      throw DatabaseException('Something went wrong');
    }
  }

  @override
  Future<String> deleteCartProduct({required String productId}) async {
    try {
      await databaseHelper.deleteCartProduct(productId: productId);
      return 'Product Removed';
    } catch (e) {
      throw DatabaseException('Something went wrong');
    }
  }

  @override
  Future<String> updateCartProduct(
      {required UpdateCartBody updateCartBody}) async {
    try {
      await databaseHelper.updateCartProduct(updateCartBody: updateCartBody);

      return 'Product Updated';
    } catch (e) {
      throw DatabaseException('Something went wrong');
    }
  }

  @override
  Future<String> deleteAllProduct() async {
    try {
      await databaseHelper.deleteAllProduct();
      return 'All product deleted';
    } catch (e) {
      throw DatabaseException('Something went wrong');
    }
  }
}
