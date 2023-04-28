import '../../models/order.dart';

class OrderState {}

class OrderStateInitial extends OrderState {}

class OrderStateSucess extends OrderState {
  Order order;
  OrderStateSucess({required this.order});
}

class OrderStateFailure extends OrderState {
  String message;
  OrderStateFailure({required this.message});
}
