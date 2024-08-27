import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/sharedpreference_helper/sharedpreference_helper.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/get_token.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/logout.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/post_login.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void init() {
  //BLoC Section
  //Auth
  locator.registerFactory(
    () => AuthBloc(
      postLogin: locator(),
      getToken: locator(),
      authLogout: locator(),
    ),
  );

  //UseCase Section
  //Auth
  locator.registerLazySingleton(() => PostLogin(authRepository: locator()));
  locator.registerLazySingleton(() => GetToken(authRepository: locator()));
  locator.registerLazySingleton(() => AuthLogout(authRepository: locator()));

  //Repository
  //Auth
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
      authLocalDatasource: locator(),
    ),
  );

  //Datasource
  //Auth
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dioClient: locator()),
  );
  locator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(
      authSharedPreferenceHelper: locator(),
    ),
  );

  //External
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton(
    () => AuthSharedPreferenceHelper(
      sharedPreference: locator(),
    ),
  );
  locator.registerLazySingleton<Future<SharedPreferences>>(
    () => SharedPreferences.getInstance(),
  );
}
