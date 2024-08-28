import 'package:dio/dio.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/sharedpreference_helper/sharedpreference_helper.dart';

class DioInterceptor extends Interceptor {
  final AuthSharedPreferenceHelper authSharedPreferenceHelper;

  DioInterceptor({required this.authSharedPreferenceHelper});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authSharedPreferenceHelper.getToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
