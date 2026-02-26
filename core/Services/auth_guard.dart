import 'package:flutter/material.dart';
import 'package:itemloca/Core/Services/ApiInterface.dart';
import 'package:itemloca/Core/Services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Pega o ApiInterface do Provider
    final apiService = context.read<ApiInterface>();
    final authService = AuthServiceLogin(apiService: apiService);
    // final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    // if (usuarioProvider.isLoggedIn) {
    //   return true;
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     context.go('/login');
    //     SnackBartComponente.show(context, 'Usuário não logado');
    //   });
    // }

    return FutureBuilder<bool>(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        print('snapshot, $snapshot');
        if (!snapshot.data!) {
          return const SizedBox.shrink();
        }

        // Usuário logado, mostra o conteúdo
        return child;
      },
    );
  }
}
