import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';

class PostProduct {
  final HomeRepository homeRepository;

  PostProduct({required this.homeRepository});

  Future<Either<Failure, void>> execute({
    required ProductBodyEntities productBody,
  }) {
    return homeRepository.postProduct(productBody: productBody);
  }
}
