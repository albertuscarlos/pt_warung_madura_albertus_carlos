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
import 'package:pt_warung_madura_albertus_carlos/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/data/datasources/db/database_helper.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/repositories/cart_repository.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/delete_all_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/delete_cart_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/get_cart_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/usecases/update_cart_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/data/repositories/home_repository_impl.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/repositories/home_repository.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/delete_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_products.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/post_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/post_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/product/product_bloc.dart';
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
    () => ProductBloc(
      getCategory: locator(),
      getProducts: locator(),
      deleteProduct: locator(),
    ),
  );
  locator.registerFactory(
    () => PostFormBloc(
      postProduct: locator(),
      postCategory: locator(),
    ),
  );
  locator.registerFactory(
    () => CartBloc(
        addProductToCart: locator(),
        getCartProduct: locator(),
        updateCartProduct: locator(),
        deleteCartProduct: locator(),
        deleteAllProduct: locator()),
  );

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
  locator.registerLazySingleton(() => DeleteProduct(homeRepository: locator()));
  //Cart
  locator
      .registerLazySingleton(() => AddProductToCart(cartRepository: locator()));
  locator
      .registerLazySingleton(() => GetCartProduct(cartRepository: locator()));
  locator.registerLazySingleton(
      () => UpdateCartProduct(cartRepository: locator()));
  locator.registerLazySingleton(
      () => DeleteCartProduct(cartRepository: locator()));
  locator
      .registerLazySingleton(() => DeleteAllProduct(cartRepository: locator()));

  //Repository
  //Auth
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: locator(),
      authLocalDatasource: locator(),
    ),
  );
  //Home
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDatasource: locator(),
    ),
  );
  //Cart
  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      cartLocalDatasource: locator(),
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
  locator.registerLazySingleton<CartLocalDatasource>(
    () => CartLocalDatasourceImpl(
      databaseHelper: locator(),
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
  locator.registerLazySingleton(() => DatabaseHelper());
}
