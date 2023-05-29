import 'package:dmfsse/src/bloc/order/order_bloc.dart';
import 'package:dmfsse/src/bloc/order/order_event.dart';
import 'package:dmfsse/src/bloc/order/order_state.dart';
import 'package:dmfsse/src/screens/customer/customer_homepage.dart';
import 'package:dmfsse/src/screens/customer/customer_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order.dart';
import '../../models/product.dart';
import '../common/widget/input_field.dart';

class CustomerOfferRoom extends StatefulWidget {
  final Product product;
  const CustomerOfferRoom({required this.product, super.key});

  @override
  State<CustomerOfferRoom> createState() => _CustomerOfferRoomState();
}

class _CustomerOfferRoomState extends State<CustomerOfferRoom> {
  final _formKey = GlobalKey<FormState>();
  bool isInOrder = false;
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: BlocConsumer<OrderBloc, OrderState>(
                    listener: ((context, state) {
                      if (state is OrderStateInitial) {
                        isInOrder = true;
                      }
                      if (state is OrderStateFailure) {
                        isInOrder = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed to send Offer")));
                        isInOrder = false;
                      }
                      if(state is OrderStateSucess){
isInOrder = false;
 Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CustomerHomepage()),
                (route) => false);
                      }
                    }),
                    builder: ((context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Quantity",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              InputTextFormField(
                                hintTxt: 'quantity',
                                controller: quantityController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "Enter product quantity",
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter product quantity";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              InputTextFormField(
                                hintTxt: 'Price',
                                controller: priceController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "product price",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter product price";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      print("send order button clicked");

                                      if (_formKey.currentState!.validate()) {
                                        Order order = Order(
                                            quantity: quantityController.text,
                                            offerPrice: priceController.text,
                                            id: widget.product.id.toString());
                                        SendOrderEvent sendOrderEvent =
                                            SendOrderEvent(order: order);
                                        BlocProvider.of<OrderBloc>(context)
                                            .add(sendOrderEvent);
                                      }
                                    },
                                    child: isInOrder
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Send Offer")),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
