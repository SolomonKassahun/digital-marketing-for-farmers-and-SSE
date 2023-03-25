import 'package:dmfsse/src/bloc/Register/register_event.dart';
import 'package:dmfsse/src/bloc/Register/register_state.dart';
import 'package:dmfsse/src/data_repository/user_data_repository.dart';
import 'package:dmfsse/src/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final UserDataRepository userDataRepository;
  User user = User();
 
  RegisterBloc(this.userDataRepository):super(InitialState()){
    on<AddBasicInfo>((event, emit) {
      emit( RegisterUpdateSucess(event.user));
    },
    );
    on<RegisterDetailInfo>((event, emit) async { 
      emit (RegisterInitial());
      bool isCreated = await  userDataRepository.createUser(event.user);
      if(isCreated){
        emit( RegistrationSucess());
      } else{
        emit (RegistraionFailure());
      }

      
    },);
  }
  
}