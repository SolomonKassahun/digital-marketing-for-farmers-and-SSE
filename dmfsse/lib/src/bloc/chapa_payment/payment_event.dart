import '../../models/payment_model.dart';

class PaymentEvent {}
class PayPaymentEvent extends PaymentEvent{
  PaymentModel paymentModel;
  PayPaymentEvent({required this.paymentModel});
}
