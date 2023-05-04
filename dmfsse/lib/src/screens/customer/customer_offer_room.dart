import 'package:dmfsse/src/bloc/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/order/order_bloc.dart';
import '../../models/product.dart';
import '../common/widget/input_field.dart';

class CustomerOfferRoom extends StatefulWidget {
  final Product product;
  const CustomerOfferRoom({required this.product, super.key});

  @override
  State<CustomerOfferRoom> createState() => _CustomerOfferRoomState();
}

class _CustomerOfferRoomState extends State<CustomerOfferRoom> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegister = false;
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(children: [
        TextSpan(
          text: 'Send your offer',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name.toString()),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              _title(),
              const SizedBox(
                height: 20,
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
                      listener: (context, state) {
                    if (state is OrderStateSucess) {}
                  }, builder: (context, state) {
                    if (state is OrderStateInitial) {
                      isRegister = true;
                    }
                    if (state is OrderStateFailure) {
                      isRegister = false;
                    }
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
                              //  InputTextFormField(),
                              InputTextFormField(
                                hintTxt: 'quantity',
                                controller: quantityController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "Enter quantity",
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter quantity";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Offer Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              InputTextFormField(
                                hintTxt: 'Offer Price',
                                controller: offerPriceController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "Enter offer price",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter offer price";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {}
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ))),
                                    child: isRegister
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Add Product")),
                              ),
                            ],
                          )),
                    );
                  }),
                ),
              ),
              // const Text(
              //   "Quantity",
              //   style:
              //       TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              // ),
              //  InputTextFormField(),
              // InputTextFormField(
              //   hintTxt: 'quantity',
              //   controller: quantityController,
              //   isRequired: false,
              //   onChanged: (String value) {},
              //   keyboardType: TextInputType.number,
              //   errorMessage: "You must enter quantity",
              //   obscureText: false,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "Enter quantity";
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Text(
              //   "Offer Price",
              //   style:
              //       TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              // ),
              // InputTextFormField(
              //   hintTxt: 'Offer price',
              //   controller: offerPriceController,
              //   isRequired: false,
              //   onChanged: (String value) {},
              //   keyboardType: TextInputType.number,
              //   errorMessage: "product price",
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "Enter product price";
              //     } else {
              //       return null;
              //     }
              //   },
              //   obscureText: false,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
