import '../../models/payment_model.dart';

class PaymentState {}
class PaymentStateInitial extends PaymentState {}
class PaymentStateLoading extends PaymentState {}
class PaymentStateSucess extends PaymentState {
  PaymentResponse paymentData;
  PaymentStateSucess({required this.paymentData});
}
class PaymentFailureState extends PaymentState {
  String message;
  PaymentFailureState({required this.message});
}