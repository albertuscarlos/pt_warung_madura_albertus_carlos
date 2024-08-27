import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';

class GetToken {
  final AuthRepository authRepository;

  GetToken({required this.authRepository});

  Future<Either<Failure, String>> execute() {
    return authRepository.getToken();
  }
}
