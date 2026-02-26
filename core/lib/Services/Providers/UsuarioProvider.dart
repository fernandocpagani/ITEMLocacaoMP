import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  int? _userId;
  int? _empresaId;
  String? _nivelUsuario;
  String? _UID;
  String? _nome;

  int? get userId => _userId;
  int? get empresaId => _empresaId;
  String? get nivelUsuario => _nivelUsuario;
  String? get nome => _nome;

  Future<void> setUsuarioFromAuth(int idUsuario, int empresaId, String nomeUsuario, String nivelUsuario) async {
    _userId = idUsuario;
    _nome = nomeUsuario;
    _empresaId = empresaId;
    _nivelUsuario = nivelUsuario;
    print('setUsuarioFromAuth $_userId, $_nome, $_nivelUsuario');
    notifyListeners();
  }

  void clear() {
    _nome = null;
    _userId = null;
    _nivelUsuario = null;
    _nivelUsuario = null;
    notifyListeners();
  }

  bool get isLoggedIn => _userId != null && _nivelUsuario != null;
}
