import 'package:dmfsse/src/data_provider/user_data_provider.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/models/user.dart';

class UserDataRepository {
  final UserDataProvider userDataProvider;
  UserDataRepository(this.userDataProvider);

  Future<LoggedInUserInfo> login(LoginInfo loginInfo) async {
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    return await userDataProvider.login(loginInfo);
  }

  Future<bool> createUser(User user) async {
    return (userDataProvider.createUser(user));
  }

  Future<User> getUserInfo(String id) async {
    print("Get user info at repo");
    return userDataProvider.getUserInfo(id);
  }
}
