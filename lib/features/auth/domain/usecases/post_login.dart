import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';

class PostLogin {
  final AuthRepository authRepository;

  PostLogin({required this.authRepository});

  Future<Either<Failure, String>> execute({
    required LoginBodyModels loginBodyModels,
  }) {
    return authRepository.login(loginBodyModels: loginBodyModels);
  }
}
