// url_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlProvider extends ChangeNotifier {
  String? _url;

  String? get url => _url;

  /// Carrega a URL salva no SharedPreferences
  Future<void> carregarUrl() async {
    final prefs = await SharedPreferences.getInstance();
    _url = prefs.getString('urlServidor');
    notifyListeners();
  }

  /// Define uma nova URL e salva no SharedPreferences
  Future<void> setUrl(String novaUrl) async {
    final prefs = await SharedPreferences.getInstance();
    _url = novaUrl;
    await prefs.setString('urlServidor', novaUrl);
    notifyListeners();
  }
}
