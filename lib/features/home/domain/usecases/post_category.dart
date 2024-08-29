import 'package:dartz/dartz.dart';
import 'package:pt_warung_madura_albertus_carlos/core/error/failure.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';

class PostCategory {
  final HomeRepository homeRepository;

  PostCategory({required this.homeRepository});

  Future<Either<Failure, String>> execute({
    required CategoryBodyEntities categoryBody,
  }) {
    return homeRepository.postCategory(categoryBody: categoryBody);
  }
}
