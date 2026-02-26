import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiInterface.dart';

class ApiService implements ApiInterface {
  String? urlBase;
  String? accessToken;
  String? refreshToken;
  DateTime? expires;
  Map<String, String> headers = {}; // cabeçalhos da API
  var prefs;

  ApiService() {
    carregarUrlBase();
  }

  @override
  Future<void> carregarUrlBase() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> _montarUrl(String endpoint) async {
    final expiresString = prefs.getString('expires');
    if (expiresString != null) {
      DateTime tokenExpires = DateTime.parse(expiresString).toLocal();
      final agora = DateTime.now();
      bool tokenVencido = agora.isAfter(tokenExpires!.subtract(const Duration(minutes: 1)));
      final precisaRenovar = tokenExpires == null || tokenVencido;
      if (tokenVencido) {
        await validarToken();
      }
    }

    if (urlBase == null || urlBase!.isEmpty) {
      throw Exception('❌ URL base não configurada. Defina em "Configurações de URL".');
    }
    final base = urlBase!.endsWith('/') ? urlBase!.substring(0, urlBase!.length - 1) : urlBase!;
    final path = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    final fullUrl = '$base/$path';
    return fullUrl;
  }

  @override
  Future<dynamic> getRequest(String url) async {
    final fullUrl = await _montarUrl(url);
    final response = await http.get(Uri.parse(fullUrl), headers: headers);
    return _handleResponse(response);
  }

  @override
  Future<dynamic> postRequest(String url, {Map<String, String>? customHeaders, dynamic body}) async {
    final fullUrl = await _montarUrl(url);
    final defaultHeaders = {'ngrok-skip-browser-warning': 'true', 'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json'};
    final mergedHeaders = {...defaultHeaders, ...?customHeaders};
    final requestBody = body is String ? body : jsonEncode(body);
    final response = await http.post(Uri.parse(fullUrl), headers: mergedHeaders, body: requestBody);
    if (response.statusCode != 200) {}
    return response;
  }

  @override
  Future<dynamic> postRequestRefreshToken(String url, {Map<String, String>? customHeaders, dynamic body}) async {
    final base = urlBase!.endsWith('/') ? urlBase!.substring(0, urlBase!.length - 1) : urlBase!;
    final path = url.startsWith('/') ? url.substring(1) : url;
    final fullUrl = '$base/$path';
    final defaultHeaders = {'ngrok-skip-browser-warning': 'true', 'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json'};
    final mergedHeaders = {...defaultHeaders, ...?customHeaders};
    final requestBody = body is String ? body : jsonEncode(body);
    final response = await http.post(Uri.parse(fullUrl), headers: mergedHeaders, body: requestBody);
    if (response.statusCode != 200) {}
    return response;
  }

  @override
  Future<void> validarToken() async {
    final accessTokenValidar = prefs.getString('accessToken') ?? '';
    final refreshTokenValidar = prefs.getString('refreshToken') ?? '';
    final body = {"accessToken": accessTokenValidar, "refreshToken": refreshTokenValidar};
    final response = await postRequestRefreshToken('api/Auth/refresh', body: body);
    final decoded = jsonDecode(response.body);
    accessToken = decoded['accessToken'].toString();
    refreshToken = decoded['refreshToken'].toString();
    expires = DateTime.tryParse(decoded['expires'].toString());
    prefs.setString('accessToken', accessToken);
    prefs.setString('refreshToken', refreshToken);
    if (expires != null) {
      await prefs.setString('expires', expires!.toIso8601String());
    }
    headers = {'ngrok-skip-browser-warning': 'true', 'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json'};
  }

  @override
  Future<dynamic> loginRequestCustomer(String url, String nucleusId, dynamic body) async {
    final urlBase = dotenv.env['API_BASE_URL']!;
    final fullUrl = '$urlBase/$url';
    final headers = {'X-Nucleus-Id': nucleusId};
    final requestBody = body is String ? body : jsonEncode(body);
    print('fullUrl loginRequestCustomer ${fullUrl}');
    print('headers loginRequestCustomer ${headers}');
    print('requestBody loginRequestCustomer ${requestBody}');
    final response = await http.post(Uri.parse(fullUrl), headers: headers, body: requestBody);
    final decoded = jsonDecode(response.body);
    accessToken = decoded['accessToken'].toString();
    refreshToken = decoded['refreshToken'].toString();
    expires = DateTime.tryParse(decoded['expires'].toString());
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    if (expires != null) {
      await prefs.setString('expires', expires!.toIso8601String());
    }
    print('resopnse loginRequestCustomer ${response}');
    return response;
  }

  @override
  Future<dynamic> putRequest(String url, {Map<String, String>? customHeaders, dynamic body}) async {
    final fullUrl = await _montarUrl(url);
    final response = await http.put(Uri.parse(fullUrl), headers: customHeaders ?? headers, body: body != null ? jsonEncode(body) : null);
    return _handleResponse(response);
  }

  @override
  Future<dynamic> deleteRequest(String url, {Map<String, String>? customHeaders, dynamic body}) async {
    final fullUrl = await _montarUrl(url);
    final response = await http.delete(Uri.parse(fullUrl), headers: customHeaders ?? headers, body: body != null ? jsonEncode(body) : null);
    return response.statusCode;
  }

  @override
  Future<dynamic> deleteServicoRequest(String url, {Map<String, String>? customHeaders, dynamic body}) async {
    final fullUrl = await _montarUrl(url);
    final response = await http.delete(Uri.parse(fullUrl), headers: customHeaders ?? headers, body: body != null ? jsonEncode(body) : null);
    return response;
  }

  @override
  Future<http.Response> uploadAnexo(String url, File file, String tipoAnexo, String tipoReferencia, String idReferencia, {Map<String, String>? customHeaders, dynamic body}) async {
    final fullUrl = await _montarUrl(url);
    final uri = Uri.parse(fullUrl);
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('File', file.path));
    request.fields['TipoAnexo'] = tipoAnexo;
    request.fields['TipoReferencia'] = tipoReferencia;
    request.fields['IDReferencia'] = idReferencia;
    request.headers.addAll(customHeaders ?? headers);
    if (body != null && body is Map<String, String>) {
      request.fields.addAll(body);
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (_) {
        return response;
      }
    } else {
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    }
  }

  dynamic _handleResponseDelete(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    }
  }
}
