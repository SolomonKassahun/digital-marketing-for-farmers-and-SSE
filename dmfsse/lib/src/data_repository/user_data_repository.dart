import 'package:dmfsse/src/data_provider/user_data_provider.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/models/user.dart';

class UserDataRepository {
  final UserDataProvider userDataProvider;
  UserDataRepository(this.userDataProvider);

  Future<LoggedInUserInfo>  login(LoginInfo loginInfo) async {
       
    return await userDataProvider.login(loginInfo);
  }
 Future<bool> createUser(User user)  async {
  print('data arrived at repo is ${userDataProvider.createUser(user)}');
  return (userDataProvider.createUser(user));
 }
}