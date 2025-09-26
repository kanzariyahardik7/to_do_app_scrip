import 'package:app_scrip/models/login_model.dart';

abstract class LoginRepository {
  Future<LoginModel?> login(Map<String, dynamic> req);
}
