import 'package:dmfsse/src/data_repository/user_data_repository.dart';
import 'package:dmfsse/src/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    });
  }
}
