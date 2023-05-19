import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:dmfsse/src/bloc/offer/offer_state.dart';
import 'package:dmfsse/src/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/widget/product_form.dart';
import 'customer_offer.dart';

class CustomerOfferUpdate extends StatefulWidget {
  final Offer offer;
  const CustomerOfferUpdate({required this.offer, super.key});

  @override
  State<CustomerOfferUpdate> createState() => _CustomerOfferUpdateState();
}

class _CustomerOfferUpdateState extends State<CustomerOfferUpdate> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> offerInfo = {};
  bool isUpdate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer.offeredProduct.name.toString()),
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
              child: BlocConsumer<OfferBloc, OfferState>(
                listener: (context, state) {
                  if(state is OfferStateSucess){
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if(state is OfferStateLoading){
                    isUpdate = true;
                  }
                  if(state is OfferStateFailure){
                    isUpdate = false;
                  }
                  return SingleChildScrollView(
                    child: Form(
                        key: formKey,
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
                            ProductTextFormField(
                              onSaved: (value) {
                                offerInfo['quantity'] = value;
                              },
                              initialValue: widget.offer.quantity.toString(),
                              onChanged: (String value) {},
                              keyboardType: TextInputType.number,
                              errorMessage: "product quantity",
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
                              height: 10.0,
                            ),
                            const Text(
                              "Offer Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ProductTextFormField(
                              onSaved: (value) {
                                offerInfo['offerPrice'] = value;
                              },
                              initialValue: widget.offer.offerPrice.toString(),
                              onChanged: (String value) {},
                              keyboardType: TextInputType.number,
                              errorMessage: "Offer Price",
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Offer Price";
                                } else {
                                  return null;
                                }
                              },
                            ),
                           const SizedBox(height: 20,),
                             Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      formKey.currentState!.save();
                                      if(formKey.currentState!.validate()){
                                        // print(widget.product.id);
                                        //  Product product = Product(
                                        //   id: widget.product.id,
                                        //   name: productBody['name'],
                                        //    price: int.parse(productBody['price']), 
                                        //    description: productBody['description'], 
                                        //    amount: int.parse(productBody['amount']),
                                        //    photo: widget.product.photo,
                                        //    soldout: widget.product.soldout,
                                           
                                        //    );
                                        // UpdateProduct updateProduct = UpdateProduct(product);
                                        //  BlocProvider.of<ProductBloc>(context)
                                        //     .add(updateProduct);
                                      }
                                       


                                    
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
                                    child: isUpdate
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Update Product")),
                              ),
                          ],
                        )),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
