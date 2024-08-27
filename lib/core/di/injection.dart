import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/repositories/auth_repository.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/post_login.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/bloc/auth_bloc.dart';

final locator = GetIt.instance;

void init() {
  //BLoC Section
  //Auth
  locator.registerFactory(() => AuthBloc(postLogin: locator()));

  //UseCase Section
  //Auth
  locator.registerLazySingleton(() => PostLogin(authRepository: locator()));

  //Repository
  //Auth
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
    ),
  );

  //Datasource
  //Auth
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dioClient: locator()),
  );

  //External
  locator.registerLazySingleton<Dio>(() => Dio());
}
