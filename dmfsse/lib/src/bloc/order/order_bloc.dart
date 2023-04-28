import 'package:dmfsse/src/bloc/order/order_event.dart';
import 'package:dmfsse/src/data_repository/order_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderDataRepostory orderDataRepostory;
  OrderBloc({required this.orderDataRepostory}) : super(OrderStateInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is SendOrderEvent) {
        try {
          emit(OrderStateInitial());
          final isOfferSent = await orderDataRepostory.sendOffer(event.order);
          if (isOfferSent) {
            emit(OrderStateSucess(order: event.order));
          } else {
            emit(OrderStateFailure(message: "Failure to sent offer"));
          }
        } catch (e) {
          emit(OrderStateFailure(message: "Failure to sent offer"));
        }
      }
      if (event is GetAllOrder) {}
    });
  }
}
