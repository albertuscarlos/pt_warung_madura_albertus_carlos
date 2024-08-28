import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';

class GetCategory {
  final HomeRepository homeRepository;

  GetCategory({required this.homeRepository});

  Future<Either<Failure, CategoryEntities>> execute() {
    return homeRepository.getCategory();
  }
}
