import 'dart:io';

abstract class ApiInterface {
  Future<dynamic> carregarUrlBase();
  Future<dynamic> getRequest(String url);
  Future<dynamic> postRequest(String url, {Map<String, String>? customHeaders, dynamic body});
  Future<dynamic> putRequest(String url, {Map<String, String>? customHeaders, dynamic body});
  Future<dynamic> deleteRequest(String url, {Map<String, String>? customHeaders, dynamic body});
  Future<dynamic> deleteServicoRequest(String url, {Map<String, String>? customHeaders, dynamic body});
  Future<dynamic> loginRequestCustomer(String url, String nucleusId, dynamic body);
  Future<dynamic> uploadAnexo(String url, File file, String tipoAnexo, String tipoReferencia, String idReferencia, {Map<String, String>? customHeaders, dynamic body});
  Future<void> validarToken();
}
