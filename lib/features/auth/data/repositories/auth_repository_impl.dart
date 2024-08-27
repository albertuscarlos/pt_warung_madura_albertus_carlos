import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, String>> login(
      {required LoginBodyModels loginBodyModels}) async {
    try {
      final result =
          await authRemoteDatasource.login(loginBodyModels: loginBodyModels);
      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(
          ConnectionFailure(
            'Tidak ada koneksi Internet!\nSilahkan periksa jaringan internet anda atau muat ulang halaman ini',
          ),
        );
      } else if (e.response!.statusCode == 401) {
        return const Left(ServerFailure('Unauthorized'));
      } else {
        return const Left(ServerFailure('Something Went Wrong'));
      }
    }
  }
}
