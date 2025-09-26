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
