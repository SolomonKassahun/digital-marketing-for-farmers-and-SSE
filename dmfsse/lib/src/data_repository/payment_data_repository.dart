import '../data_provider/payment_data_provider.dart';
import '../models/payment_model.dart';

class PaymentDataRepository {
  PaymentDataProvider paymentDataProvider;
  PaymentDataRepository({required this.paymentDataProvider});

  Future<PaymentResponse> payPayemnt(PaymentModel paymentModel) {
    return paymentDataProvider.payPayemnt(paymentModel);
  }
}