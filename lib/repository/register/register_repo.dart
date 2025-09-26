import 'package:app_scrip/models/register_model.dart';

abstract class RegisterRepository {
  Future<RegisterModel?> register(Map<String, dynamic> req);
}
