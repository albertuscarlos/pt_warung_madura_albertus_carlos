import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';

abstract class HomeRepository {
  Future<Either<Failure, CategoryEntities>> getCategory();
  Future<Either<Failure, ProductEntities>> getProducts();
  Future<Either<Failure, String>> postCategory({
    required CategoryBodyEntities categoryBody,
  });
  Future<Either<Failure, String>> postProduct({
    required ProductBodyEntities productBody,
  });
  Future<Either<Failure, String>> deleteProduct({required String productId});
}
