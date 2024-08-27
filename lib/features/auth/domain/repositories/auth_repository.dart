import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login({
    required LoginBodyModels loginBodyModels,
  });
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, void>> logout();
}
