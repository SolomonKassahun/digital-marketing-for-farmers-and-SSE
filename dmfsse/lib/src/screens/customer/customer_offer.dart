import 'package:chapasdk/chapa_payment%20initializer.dart';
import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../bloc/offer/offer_event.dart';
import '../../bloc/offer/offer_state.dart';
import '../../models/payment_model.dart';
import '../common/widget/payment_dailog_box.dart';
import 'customer_offer_detail.dart';
import 'customer_offer_update.dart';

class CustomerOffer extends StatefulWidget {
  const CustomerOffer({super.key});

  @override
  State<CustomerOffer> createState() => _CustomerOfferState();
}

class _CustomerOfferState extends State<CustomerOffer> {
  @override
  void initState() {
    BlocProvider.of<OfferBloc>(context).add(GetMyOrderEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OfferBloc>(context).add(GetMyOrderEvent());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Your Order",
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<OfferBloc, OfferState>(
            builder: (context, state) {
              if (state is OfferStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              if (state is OfferStateFailure) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                  ),
                );
              }
              if (state is OfferStateSucess) {
                return SingleChildScrollView(
                  child: Column(
                    children: state.offer
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerOfferDetail(
                                                offer: e,
                                              )));
                                },
                                child: Card(
                                  child: SizedBox(
                                    height: 70.0,
                                    child: ListTile(
                                        leading: const Icon(Icons.local_offer,color:  Color.fromARGB(255, 15, 23, 43),),
                                        title: Text(e.offeredProduct.name,style:const  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        trailing: (e.accepted == 'accepted')
                                            ? ElevatedButton(
                                               style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 15, 23, 43),),
                      
                      ),
                                                onPressed: () {
                                                  print('pressed');
                                                  PaymentModel offerModel = PaymentModel(
                                                    context: context,
                                                      amount:
                                                          e.quantity.toString(),
                                                      currency: 'ETB',
                                                      email: '${e.orderBy.firstName}${e.orderBy.lastName}@gmail.com',
                                                      firstName:
                                                          e.orderBy.firstName,
                                                      lastName:
                                                          e.orderBy.lastName,
                                                      phoneNumber: "0333333333",
                                                      txtRef:
                                                         e.id,
                                                      callbackUrl:
                                                          "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60",
                                                      customization:
                                                          "Thank for banking us.");
                                                  // Chapa.paymentParameters(
                                                  //     context: context,
                                                  //     publicKey:
                                                  //         'CHASECK_TEST-Zy6eSfeshRoHHsxDS4Ccf1dzuIgHIHtv',
                                                  //     currency: 'ETB',
                                                  //     amount:
                                                  //         e.quantity.toString(),
                                                  //     email:
                                                  //         "${e.orderBy.firstName}${e.orderBy.lastName}@gmail.com",
                                                  //     phone: "0953890542",
                                                  //     firstName:
                                                  //         e.orderBy.firstName,
                                                  //     lastName:
                                                  //         e.orderBy.lastName,
                                                  //     txRef: e.id,
                                                  //     title:
                                                  //         "Payment for my favourite merchant",
                                                  //     desc:
                                                  //         'Thank for banking us.',
                                                  //     namedRouteFallBack:
                                                  //         '/customerHomepage');
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          PaymentAlertDialogBox(
                                                            paymentModel:
                                                                offerModel,
                                                          ));
                                                },
                                                child: const Text("Payment"))
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CustomerOfferUpdate(
                                                                          offer:
                                                                              e,
                                                                        )));
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit,color: Colors.blue,)),
                                                  IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                "Offer Deleted"),
                                                            content: const Text(
                                                                "Do you want to delete Offer?"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(14),
                                                                  child:
                                                                      const Text(
                                                                          "Yes"),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(14),
                                                                  child:
                                                                      const Text(
                                                                          "No"),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),color: Colors.red,)
                                                ],
                                              )),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              }

              return const Text("Failed to load offer");
            },
          ),
        ],
      ),
    );
  }
}
