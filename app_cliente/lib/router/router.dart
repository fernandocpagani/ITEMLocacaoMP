import 'package:app_cliente/Screens/ItensScreen/ItensScreen.dart';
import 'package:app_cliente/Screens/LocadoresScreen/LocadoresScreen.dart';
import 'package:app_cliente/Screens/Login/LoginScreenCliente.dart';
import 'package:app_cliente/Screens/MarketPlace/MaketPlaceScreen.dart';
import 'package:app_cliente/Screens/MinhasAssociacoes/MinhasAssociacoes.dart';
import 'package:app_cliente/Screens/MinhasLocacoesScreen/MinhasLocacoesScreen.dart';
import 'package:app_cliente/Screens/PerfilScreen/PerfilScreen.dart';
import 'package:core/Screens/Inicial/PaginaInicial.dart';
import 'package:core/Services/auth_guard.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreenCliente()),
    GoRoute(
      path: '/paginainicial',
      builder: (context, state) => const AuthGuard(child: PaginaInicial()),
    ),
    GoRoute(path: '/marketplace', builder: (context, state) => MarketPlaceScreen()),
    GoRoute(path: '/marketplace/explore', builder: (context, state) => ItensScreen()),
    GoRoute(path: '/marketplace/nucleos', builder: (context, state) => LocadoresScreen()),
    GoRoute(path: '/marketplace/minhaslocacoes', builder: (context, state) => MinhasLocacoesScreen()),
    GoRoute(path: '/marketplace/memberships', builder: (context, state) => MinhasAssociacoes()),
    GoRoute(path: '/marketplace/perfil', builder: (context, state) => PerfilScreen()),
  ],
);
