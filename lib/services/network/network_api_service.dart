import 'dart:io';
import 'package:app_scrip/services/network/base_api_service.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkApiService extends BaseApiService {
  late Dio _dio;

  NetworkApiService({required Dio dio}) {
    _dio = Dio(
      BaseOptions(
        responseType: ResponseType.json,
        headers: {"x-api-key": "reqres-free-v1"},
        validateStatus: (status) {
          if (status == null) {
            return false;
          } else {
            return true;
          }
        },
      ),
    )..interceptors.addAll([LogInterceptor(), PrettyDioLogger()]);
  }

  // GET request
  @override
  Future<Response> getResponse(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on SocketException {
      Utils.toastMessage("No Internet Connection", fail);
      throw Exception("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  @override
  Future<Response> postResponse(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on SocketException {
      Utils.toastMessage("No Internet Connection", fail);
      throw Exception("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  @override
  Future<Response> putResponse(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } on SocketException {
      Utils.toastMessage("No Internet Connection", fail);
      throw Exception("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  @override
  Future<Response> deleteResponse(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } on SocketException {
      Utils.toastMessage("No Internet Connection", fail);
      throw Exception("No Internet Connection");
    } catch (e) {
      rethrow;
    }
  }
}
