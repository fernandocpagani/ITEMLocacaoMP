import 'package:go_router/go_router.dart';
import 'package:itemloca/Pages/Inicial/PaginaInicial.dart';
import 'package:itemloca/Pages/Login/LoginScreen.dart';
import 'package:itemloca/Core/Services/auth_guard.dart';

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
