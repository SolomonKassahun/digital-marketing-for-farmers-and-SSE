import 'package:dmfsse/src/bloc/order/order_bloc.dart';
import 'package:dmfsse/src/bloc/order/order_event.dart';
import 'package:dmfsse/src/bloc/order/order_state.dart';
import 'package:dmfsse/src/screens/customer/customer_homepage.dart';
import 'package:dmfsse/src/screens/customer/customer_offer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/locale_keys.g.dart';
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
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 15, 23, 43),
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
                      if (state is OrderStateSucess) {
                        isInOrder = false;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CustomerHomepage()),
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
                               Text(
                               LocaleKeys.quantityText.tr(),
                                style:const  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:  Color.fromARGB(255, 15, 23, 43)),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              InputTextFormField(
                                hintTxt: LocaleKeys.quantityText.tr(),
                                controller: quantityController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: LocaleKeys.quantityText.tr(),
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.quantityText.tr();
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                               Text(
                                LocaleKeys.productpriceText.tr(),
                                style: const  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:  Color.fromARGB(255, 15, 23, 43)),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              InputTextFormField(
                                hintTxt:  LocaleKeys.productpriceText.tr(),
                                controller: priceController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage:  LocaleKeys.productpriceText.tr(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return  LocaleKeys.productpriceText.tr();
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
                                  style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(const Color.fromARGB(255, 15, 23, 43)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ))),
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
                                        :  Text( LocaleKeys.sendOfferText.tr())),
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
