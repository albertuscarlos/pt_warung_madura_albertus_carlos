import 'package:go_router/go_router.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/presentation/pages/login_page.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/pages/cart_page.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      //Login route
      GoRoute(
        path: '/',
        name: 'login_page',
        builder: (context, state) => const LoginPage(),
      ),
      //Home Route
      GoRoute(
        path: '/home',
        name: 'home_page',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'cart',
            name: 'cart_page',
            builder: (context, state) => const CartPage(),
          ),
        ],
      ),
    ],
  );
}
