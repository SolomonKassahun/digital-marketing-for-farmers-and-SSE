import '../../models/user.dart';

class RegisterEvent {}
class Initialization extends RegisterEvent {}
class AddBasicInfo extends RegisterEvent {
  final User user;
  AddBasicInfo(this.user);
  
}
class RegisterDetailInfo extends RegisterEvent {
  final User user;
  RegisterDetailInfo(this.user);
}