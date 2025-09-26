import 'package:app_scrip/models/user_list_model.dart';
import 'package:app_scrip/repository/user/user_repo.dart';
import 'package:app_scrip/services/network/api_end_points.dart';
import 'package:app_scrip/services/network/network_api_service.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkApiService networkApiService;
  UserRepositoryImpl({required this.networkApiService});

  // Get user list
  @override
  Future<UserListModel?> getUsers(Map<String, dynamic> query) async {
    try {
      final Response response = await networkApiService.getResponse(
        ApiEndPoints.getUsers,
        queryParameters: query,
      );

      if (response.statusCode == 200) {
        return UserListModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to fetch users: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get single user
  @override
  Future<SingleUserModel?> getSingleUser(int userId) async {
    try {
      final Response response = await networkApiService.getResponse(
        "${ApiEndPoints.getSingleUser}/$userId",
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        return SingleUserModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to fetch user: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
