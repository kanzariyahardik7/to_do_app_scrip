import 'package:app_scrip/models/login_model.dart';
import 'package:app_scrip/repository/login/login_repo.dart';
import 'package:app_scrip/services/response/api_response.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/user_preferences.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepository;
  LoginViewModel({required this.loginRepository});

  //-------------------------------------------------------------
  ApiResponse<LoginModel> loginApiResponse = ApiResponse.init();

  void _setLoginApiResponse(ApiResponse<LoginModel> response) {
    loginApiResponse = response;
    notifyListeners();
  }

  Future<void> login(Map<String, dynamic> query, BuildContext context) async {
    _setLoginApiResponse(ApiResponse.loading());

    try {
      final response = await loginRepository.login(query);

      if (response?.token != null) {
        // for the api success reponse
        _setLoginApiResponse(ApiResponse.completed(response));

        //save token here
        UserPreferences.setToken(response?.token ?? "");

        // show message
        Utils.toastMessage("Login Successfully", success);

        //navigat to tasklist page
        context.go("/tasklist");
      } else {
        // for the api fail reponse, show error message
        _setLoginApiResponse(
          ApiResponse.error(response?.error ?? "Unknown error"),
        );
        Utils.toastMessage(response?.error ?? "Unknown error", fail);
      }
    } catch (e) {
      // for the other error catching handling
      _setLoginApiResponse(ApiResponse.error(e.toString()));
      Utils.toastMessage(e.toString(), fail);
    }
  }
}
