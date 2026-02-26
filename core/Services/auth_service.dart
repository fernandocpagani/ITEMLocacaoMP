import 'package:itemloca/Core/Services/ApiInterface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceLogin {
  final ApiInterface apiService;

  AuthServiceLogin({required this.apiService});

  Future<dynamic> loginCustumer(String email, String nucleusId, String senha) async {
    final body = {"email": email, "nucleusId": nucleusId, "password": senha};
    var response;
    try {
      response = await apiService.loginRequestCustomer('api/Auth/login', nucleusId, body);
      print('response AuthServiceLogin ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        await prefs.setString('email', email);
        await prefs.setString('nucleusId', nucleusId);
      }
    } catch (e) {
      print('Erro ao logar: $e');
    }
    return response;
  }

  /// Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('idUsuario');
    await prefs.remove('idEmpresa');
    await prefs.remove('password');
    await prefs.remove('nomeUsuario');
    await prefs.remove('nivelUsuario');
  }

  /// Verifica se está logado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    print('isLoggedIn ${prefs.getBool('loggedIn')}');
    return prefs.getBool('loggedIn') ?? false;
  }
}
