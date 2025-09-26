import 'package:app_scrip/models/user_list_model.dart';
import 'package:app_scrip/repository/user/user_repo.dart';
import 'package:app_scrip/services/response/api_response.dart';
import 'package:app_scrip/services/response/api_status.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  UserViewModel({required this.userRepository});

  //-------------------------------------------------------------
  ApiResponse<UserListModel> getUsersApiResponse = ApiResponse.init();
  List<UserModel> userList = [];

  int currentPage = 0;
  int totalPages = 0;
  int perPage = 4;

  void _setUsersApiResponse(ApiResponse<UserListModel> response) {
    getUsersApiResponse = response;
    if (response.status == Status.completed) {
      currentPage = response.data?.page ?? 0;
      totalPages = response.data?.totalPages ?? 0;
      userList.addAll(response.data?.data ?? []);
    }
    notifyListeners();
  }

  Future<void> fetchUsers(Map<String, dynamic> query) async {
    _setUsersApiResponse(ApiResponse.loading());

    try {
      final response = await userRepository.getUsers(query);

      if (response!.data!.isNotEmpty) {
        // for the api success reponse
        _setUsersApiResponse(ApiResponse.completed(response));
      } else {
        // for the api fail reponse, show error message
        _setUsersApiResponse(
          ApiResponse.error(response.error ?? "Unknown error"),
        );
        Utils.toastMessage(response.error ?? "Unknown error", fail);
      }
    } catch (e) {
      // for the other error catching handling
      _setUsersApiResponse(ApiResponse.error(e.toString()));
      Utils.toastMessage(e.toString(), fail);
    }
  }

  resetUserData() {
    getUsersApiResponse = ApiResponse.init();
    userList = [];
    currentPage = 0;
    totalPages = 0;
  }

  //-------------------------------------------------------------
  ApiResponse<SingleUserModel> getSingleUserApiResponse = ApiResponse.init();

  void _setSingleUserApiResponse(ApiResponse<SingleUserModel> response) {
    getSingleUserApiResponse = response;
    notifyListeners();
  }

  Future<void> fetchSingleUser(int userid) async {
    _setSingleUserApiResponse(ApiResponse.loading());

    try {
      final response = await userRepository.getSingleUser(userid);

      if (response!.data != null) {
        // for the api success reponse
        _setSingleUserApiResponse(ApiResponse.completed(response));
      } else {
        // for the api fail reponse, show error message
        _setSingleUserApiResponse(
          ApiResponse.error(response.error ?? "Unknown error"),
        );
        Utils.toastMessage(response.error ?? "Unknown error", fail);
      }
    } catch (e) {
      // for the other error catching handling
      _setSingleUserApiResponse(ApiResponse.error(e.toString()));
      Utils.toastMessage(e.toString(), fail);
    }
  }
}
