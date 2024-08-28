import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImpl({required this.homeRemoteDatasource});

  @override
  Future<Either<Failure, CategoryEntities>> getCategory() async {
    try {
      final result = await homeRemoteDatasource.getCategory();
      return Right(result.toEntities());
    } on DioException catch (e) {
      final error = e.response?.data;
      if (e.type == DioExceptionType.connectionError) {
        return const Left(
          ConnectionFailure(
            'No Internet connection!\nPlease check your internet connection and try again',
          ),
        );
      } else if (e.response!.statusCode == 400) {
        return Left(ServerFailure(error['message']));
      } else if (e.response!.statusCode == 401) {
        return const Left(ServerFailure('Unauthorized'));
      } else {
        return const Left(ServerFailure('Something went wrong in the server'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntities>> getProducts() async {
    try {
      final result = await homeRemoteDatasource.getProduct();
      return Right(result.toEntities());
    } on DioException catch (e) {
      final error = e.response?.data;
      if (e.type == DioExceptionType.connectionError) {
        return const Left(
          ConnectionFailure(
            'No Internet connection!\nPlease check your internet connection and try again',
          ),
        );
      } else if (e.response!.statusCode == 400) {
        return Left(ServerFailure(error['message']));
      } else if (e.response!.statusCode == 401) {
        return const Left(ServerFailure('Unauthorized'));
      } else {
        return const Left(ServerFailure('Something went wrong in the server'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> postCategory(
      {required CategoryBodyEntities categoryBody}) async {
    try {
      final result =
          await homeRemoteDatasource.postCategory(categoryBody: categoryBody);
      return Right(result);
    } on DioException catch (e) {
      final error = e.response?.data;
      if (e.type == DioExceptionType.connectionError) {
        return const Left(
          ConnectionFailure(
            'No Internet connection!\nPlease check your internet connection and try again',
          ),
        );
      } else if (e.response!.statusCode == 400) {
        return Left(ServerFailure(error['message']));
      } else if (e.response!.statusCode == 401) {
        return const Left(ServerFailure('Unauthorized'));
      } else {
        return const Left(ServerFailure('Something went wrong in the server'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> postProduct(
      {required ProductBodyEntities productBody}) async {
    try {
      final result =
          await homeRemoteDatasource.postProduct(productBody: productBody);
      return Right(result);
    } on DioException catch (e) {
      final error = e.response?.data;
      if (e.type == DioExceptionType.connectionError) {
        return const Left(
          ConnectionFailure(
            'No Internet connection!\nPlease check your internet connection and try again',
          ),
        );
      } else if (e.response!.statusCode == 400) {
        return Left(ServerFailure(error['message']));
      } else if (e.response!.statusCode == 401) {
        return const Left(ServerFailure('Unauthorized'));
      } else {
        return const Left(ServerFailure('Something went wrong in the server'));
      }
    }
  }
}
