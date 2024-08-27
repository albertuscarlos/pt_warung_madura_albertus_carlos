import 'dart:developer';

import 'package:pt_warung_madura_albertus_carlos/core/constants/constants.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatasource {
  Future<String> login({required LoginBodyModels loginBodyModels});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dioClient;

  AuthRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<String> login({
    required LoginBodyModels loginBodyModels,
  }) async {
    try {
      final request = await dioClient.post(
        Constants.loginUrl,
        data: loginBodyModels.toJson(),
      );
      if (request.statusCode == 200) {
        return request.data['data']['token'];
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
