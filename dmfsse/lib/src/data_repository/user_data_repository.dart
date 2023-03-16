import 'package:dmfsse/src/data_provider/user_data_provider.dart';
import 'package:dmfsse/src/models/login_info.dart';

class UserDataRepository {
  final UserDataProvider userDataProvider;
  UserDataRepository(this.userDataProvider);

  Future<LoggedInUserInfo>  login(LoginInfo loginInfo) async {
       
    return await userDataProvider.login(loginInfo);
  }
}