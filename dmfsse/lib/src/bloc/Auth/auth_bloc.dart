// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:dmfsse/src/bloc/Auth/auth_event.dart';
import 'package:dmfsse/src/bloc/Auth/auth_state.dart';
import 'package:dmfsse/src/data_repository/user_data_repository.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserDataRepository userDataRepository;

  LoginBloc(this.userDataRepository) : super(LoginInitial()) {
    on<Loging>((event, emit) => mapEventToStateLoging(event.loginInfo));
    on<LogOut>((event, emit) => mapEventToStateLogout());
  }

  void mapEventToStateLoging(LoginInfo loginModel) async {
   
    
    emit(LoginingState());
   
    try {

      LoggedInUserInfo user = await userDataRepository.login(loginModel);

      emit(LoginSucess(user));
    } on HttpException catch (e) {
     
      emit(LoginFailure(e.message));
    } catch (e) {

      emit(LoginFailure("login failed"));
    }
  }

  void mapEventToStateLogout() {}
}
