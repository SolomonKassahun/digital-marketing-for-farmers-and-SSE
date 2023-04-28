import '../../models/order.dart';

class OrderEvent {}

class SendOrderEvent extends OrderEvent {
  Order order;
  SendOrderEvent({required this.order});
}

class GetAllOrder extends OrderEvent {}
