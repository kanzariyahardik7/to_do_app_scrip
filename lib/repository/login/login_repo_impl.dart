import 'package:app_scrip/models/login_model.dart';
import 'package:app_scrip/repository/login/login_repo.dart';
import 'package:app_scrip/services/network/api_end_points.dart';
import 'package:app_scrip/services/network/network_api_service.dart';
import 'package:dio/dio.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkApiService networkApiService;
  LoginRepositoryImpl({required this.networkApiService});

  @override
  Future<LoginModel?> login(Map<String, dynamic> req) async {
    try {
      // Send POST request and get raw Response
      final Response response = await networkApiService.postResponse(
        ApiEndPoints.login,
        data: req,
      );

      // Check status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      } else {
        // Handle errors based on status code
        throw Exception(
          'Login failed: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
