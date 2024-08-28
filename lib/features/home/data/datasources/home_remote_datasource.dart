import 'package:dio/dio.dart';
import 'package:pt_warung_madura_albertus_carlos/core/constants/constants.dart';
import 'package:pt_warung_madura_albertus_carlos/core/dio/dio_interceptor.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/models/category_model.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/models/product_model.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_body_entities.dart';

abstract class HomeRemoteDatasource {
  Future<CategoryModel> getCategory();
  Future<ProductModel> getProduct();
  Future<void> postCategory({required CategoryBodyEntities categoryBody});
  Future<void> postProduct({required ProductBodyEntities productBody});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final Dio dio;
  final DioInterceptor dioInterceptor;

  HomeRemoteDatasourceImpl({required this.dio, required this.dioInterceptor});

  @override
  Future<CategoryModel> getCategory() async {
    dio.interceptors.add(dioInterceptor);
    try {
      final request = await dio.get(Constants.categoryUrl);

      if (request.statusCode == 200) {
        return CategoryModel.fromJson(request.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProduct() async {
    try {
      final request = await dio.get(Constants.productsUrl);

      if (request.statusCode == 200) {
        return ProductModel.fromJson(request.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> postCategory({
    required CategoryBodyEntities categoryBody,
  }) async {
    try {
      final request =
          await dio.post(Constants.categoryUrl, data: categoryBody.toJson());

      if (request.statusCode == 200) {
        return Future.value(null);
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> postProduct({required ProductBodyEntities productBody}) async {
    try {
      final picture = productBody.productImage;
      if (picture != null) {
        final pictureName = picture.path.split('/').last;
        final FormData productData = FormData.fromMap({
          'category_id': productBody.category,
          'name': productBody.productName,
          'price': productBody.price,
          'picture': await MultipartFile.fromFile(
            picture.path,
            filename: pictureName,
          ),
        });

        final request =
            await dio.post(Constants.productsUrl, data: productData);
        if (request.statusCode == 200) {
          return Future.value(null);
        } else {
          throw Exception();
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
