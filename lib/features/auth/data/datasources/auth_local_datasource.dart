import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/sharedpreference_helper/sharedpreference_helper.dart';

abstract class AuthLocalDatasource {
  Future<void> setToken({required String token});
  Future<String> getToken();
  Future<void> removeToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final AuthSharedPreferenceHelper authSharedPreferenceHelper;

  AuthLocalDatasourceImpl({required this.authSharedPreferenceHelper});

  @override
  Future<String> getToken() async {
    final request = await authSharedPreferenceHelper.getToken;
    if (request != null) {
      return Future.value(request);
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> removeToken() async {
    await authSharedPreferenceHelper.removeToken();
  }

  @override
  Future<void> setToken({required String token}) async {
    await authSharedPreferenceHelper.setToken(token);
  }
}
