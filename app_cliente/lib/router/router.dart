import 'package:core/Screens/Inicial/PaginaInicial.dart';
import 'package:core/Screens/Login/LoginScreen.dart';
import 'package:core/Services/auth_guard.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/paginainicial',
      builder: (context, state) => const AuthGuard(child: PaginaInicial()),
    ),
  ],
);
