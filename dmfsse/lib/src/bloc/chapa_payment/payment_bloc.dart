import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_repository/payment_data_repository.dart';
import '../../models/payment_model.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent,PaymentState> {
  PaymentDataRepository paymentDataRepository;
  PaymentBloc({required this.paymentDataRepository}):super(PaymentStateInitial()){
    on<PaymentEvent>((event, emit) async{
  if(event is PayPaymentEvent){
    emit (PaymentStateLoading());
    try {
      final payment = await paymentDataRepository.payPayemnt(event.paymentModel);
      // ignore: unnecessary_type_check
      if(payment is PaymentResponse){
 emit(PaymentStateSucess(paymentData: payment));
      } else{
         emit (PaymentFailureState(message: "Failed to pay"));
      }
    } catch (e) {
     emit (PaymentFailureState(message: "Failed to pay"));
    }
  }
    });
  }
  
}