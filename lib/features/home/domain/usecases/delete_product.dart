import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';

class DeleteProduct {
  final HomeRepository homeRepository;

  DeleteProduct({required this.homeRepository});

  Future<Either<Failure, String>> execute({required String productId}) {
    return homeRepository.deleteProduct(productId: productId);
  }
}
