import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';

class GetProducts {
  final HomeRepository homeRepository;

  GetProducts({required this.homeRepository});

  Future<Either<Failure, ProductEntities>> execute() {
    return homeRepository.getProducts();
  }
}
