import 'package:app_scrip/models/register_model.dart';
import 'package:app_scrip/repository/register/register_repo.dart';
import 'package:app_scrip/services/network/api_end_points.dart';
import 'package:app_scrip/services/network/network_api_service.dart';
import 'package:dio/dio.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkApiService networkApiService;

  RegisterRepositoryImpl({required this.networkApiService});

  @override
  Future<RegisterModel?> register(Map<String, dynamic> req) async {
    try {
      // Send POST request and get raw Response
      final Response response = await networkApiService.postResponse(
        ApiEndPoints.register,
        data: req,
      );

      // Check status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterModel.fromJson(response.data);
      } else {
        // Handle errors based on status code
        throw Exception(
          'Registration failed: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
