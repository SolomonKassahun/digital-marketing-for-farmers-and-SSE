import 'package:dmfsse/src/data_repository/user_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/login_info.dart';
import '../../models/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDataRepository userDataRepository;
  UserBloc(this.userDataRepository) : super(UserStateInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserInfoEvent) {
        emit(UserStateInitial());
        try {
          final userInfo = await userDataRepository.getUserInfo(event.id);
          // ignore: unnecessary_type_check
          if (userInfo is User) {
            emit(GetUserInfoSucess(user: userInfo));
          } else {
            emit(GetUserInfoFailure(
                message: "No internet. Failed to load user"));
          }
        } catch (e) {
          throw Exception(e);
        }
      }
      if(event is GetUserByPhoneNumber){
        emit (GetUserInfoInitial());
        try {
           GetUserInfoByPhoneNumber  user = await userDataRepository.getUserByPhoneNumber(event.phoneNumber);
           // ignore: unnecessary_null_comparison
           if(user != null){
                     emit (GetUserInfoByPhoneNumberSucess(user: user));
           } 
           emit(GetUserInfoFailure(
                message: "No internet. Failed to load user"));
        } catch (e) {
          emit (GetUserInfoFailure(message: e.toString()));
        }
      }
      if(event is ForgetPasswordEvent){
        emit (UserForgetPasswordInitial());
        try {
          bool forgetPassword = await userDataRepository.forgetPassword(event.newPassword, event.userId);
         if(forgetPassword){
          emit (UserForgetPasswordSuccess());
         }
         else{
           emit(GetUserInfoFailure(
                message: "Failed to forget password"));
         }
        } catch (e) {
          emit(GetUserInfoFailure(
                message: "Failed to forget password"));
        }
      }
    });
  }
}
