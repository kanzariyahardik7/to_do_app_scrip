// abstract class BaseApiService {
//   Future<dynamic> getResponse(String url, Map<String, dynamic> queryParameters);
//   Future postResponse(String urlPath, Map<String, String> jsonBody);
//   Future putResponse(String urlPath, Map<String, dynamic> jsonBody);
//   Future deleteResponse(String urlPath, Map<String, dynamic> jsonBody);
// }

import 'package:dio/dio.dart';

abstract class BaseApiService {
  /// GET request
  Future<Response> getResponse(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  /// POST request
  Future<Response> postResponse(String url, {Map<String, dynamic>? data});

  /// PUT request
  Future<Response> putResponse(String url, {Map<String, dynamic>? data});

  /// DELETE request
  Future<Response> deleteResponse(String url, {Map<String, dynamic>? data});
}
