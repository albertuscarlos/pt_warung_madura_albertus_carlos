import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/config/routes.dart';
import 'package:pt_warung_madura_albertus_carlos/config/themes.dart';
import 'package:pt_warung_madura_albertus_carlos/core/di/injection.dart' as di;
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<AuthBloc>()
            ..add(
              AuthenticationCheck(),
            ),
        ),
        BlocProvider(
          create: (context) => di.locator<ProductBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PostFormBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<CartBloc>(),
        ),
      ],
      child: MaterialApp.router(
        theme: CustomThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
