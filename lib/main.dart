import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/config/routes.dart';
import 'package:pt_warung_madura_albertus_carlos/config/themes.dart';
import 'package:pt_warung_madura_albertus_carlos/core/di/injection.dart' as di;
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<AuthBloc>()),
      ],
      child: MaterialApp.router(
        theme: CustomThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
