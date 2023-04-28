import 'package:dmfsse/src/data_provider/order_data_provider.dart';

import '../models/order.dart';

class OrderDataRepostory {
  final OrderDataProvider orderDataProvider;
  OrderDataRepostory({required this.orderDataProvider});

  Future<bool> sendOffer(Order order) async {
    return orderDataProvider.sendOffer(order);
  }
}
