import 'package:app_scrip/models/register_model.dart';
import 'package:app_scrip/repository/register/register_repo.dart';
import 'package:app_scrip/services/response/api_response.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/user_preferences.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository registerRepository;
  RegisterViewModel({required this.registerRepository});

  //-------------------------------------------------------------
  ApiResponse<RegisterModel> registerApiResponse = ApiResponse.init();

  void _setRegisterApiResponse(ApiResponse<RegisterModel> response) {
    registerApiResponse = response;
    notifyListeners();
  }

  Future<void> register(Map<String, dynamic> body, BuildContext context) async {
    _setRegisterApiResponse(ApiResponse.loading());

    try {
      final response = await registerRepository.register(body);

      if (response?.token != null) {
        // for the api success reponse
        _setRegisterApiResponse(ApiResponse.completed(response));

        //save token here
        UserPreferences.setToken(response?.token ?? "");

        // show message
        Utils.toastMessage("Register Successfully", success);

        //navigat to tasklist page
        context.go("/tasklist");
      } else {
        // for the api fail reponse, show error message
        _setRegisterApiResponse(
          ApiResponse.error(response?.error ?? "Unknown error"),
        );
        Utils.toastMessage(response?.error ?? "Unknown error", fail);
      }
    } catch (e) {
      // for the other error catching handling
      _setRegisterApiResponse(ApiResponse.error(e.toString()));
      Utils.toastMessage(e.toString(), fail);
    }
  }
}
