import '../../models/user_registeration_info.dart';

class RegisterEvent {}

class Initialization extends RegisterEvent {}

class AddBasicInfo extends RegisterEvent {
  final UserRegisterationInfo user;
  AddBasicInfo(this.user);
}

class RegisterDetailInfo extends RegisterEvent {
  final UserRegisterationInfo user;
  RegisterDetailInfo(this.user);
}
