import 'package:app_scrip/models/user_list_model.dart';

abstract class UserRepository {
  Future<UserListModel?> getUsers(Map<String, dynamic> query);
  Future<SingleUserModel?> getSingleUser(int userId);
}
