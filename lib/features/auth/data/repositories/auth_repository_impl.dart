import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, String>> login({
    required LoginBodyModels loginBodyModels,
  }) async {
    try {
      final result = await authRemoteDatasource.login(
        loginBodyModels: loginBodyModels,
      );
      log('Repo Impl Token: $result');
      await authLocalDatasource.setToken(token: result);
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
  Future<Either<Failure, String>> getToken() async {
    try {
      final result = await authLocalDatasource.getToken();
      return Right(result);
    } catch (e) {
      return const Left(DatabaseFailure('Something Went Wrong'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authLocalDatasource.removeToken();
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Something Went Wrong'));
    }
  }
}
