import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pt_warung_madura_albertus_carlos/core/dio/dio_interceptor.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/sharedpreference_helper/sharedpreference_helper.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/get_token.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/logout.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/post_login.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/repositories/home_repository_impl.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_products.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/post_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/post_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/home_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';
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
  locator.registerFactory(
    () => HomeBloc(
      getCategory: locator(),
      getProducts: locator(),
    ),
  );
  locator.registerFactory(() => PostFormBloc(
        postProduct: locator(),
        postCategory: locator(),
      ));

  //UseCase Section
  //Auth
  locator.registerLazySingleton(() => PostLogin(authRepository: locator()));
  locator.registerLazySingleton(() => GetToken(authRepository: locator()));
  locator.registerLazySingleton(() => AuthLogout(authRepository: locator()));
  //Home
  locator.registerLazySingleton(() => GetCategory(homeRepository: locator()));
  locator.registerLazySingleton(() => GetProducts(homeRepository: locator()));
  locator.registerLazySingleton(() => PostCategory(homeRepository: locator()));
  locator.registerLazySingleton(() => PostProduct(homeRepository: locator()));

  //Repository
  //Auth
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
      authLocalDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDatasource: locator(),
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
  locator.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(
      dio: locator(),
      dioInterceptor: locator(),
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
  locator.registerLazySingleton(
    () => DioInterceptor(
      authSharedPreferenceHelper: locator(),
    ),
  );
}
