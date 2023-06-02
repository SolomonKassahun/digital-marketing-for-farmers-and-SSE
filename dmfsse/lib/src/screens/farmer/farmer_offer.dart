import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../bloc/offer/offer_event.dart';
import '../../bloc/offer/offer_state.dart';
import '../../models/payment_model.dart';
import 'farmer_offer_detail.dart';

class FarmerOffer extends StatefulWidget {
  const FarmerOffer({super.key});

  @override
  State<FarmerOffer> createState() => _FarmerOfferState();
}

class _FarmerOfferState extends State<FarmerOffer> {
  @override
  void initState() {
    BlocProvider.of<OfferBloc>(context).add(GetMyOfferEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OfferBloc>(context).add(GetMyOfferEvent());
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Your Offer",
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
                return const Center(child: Text("Failed to load Offer"));
              }
              if (state is OfferStateSucess) {
                return SingleChildScrollView(
                  child: Column(
                    children: state.offer
                        .map((e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FarmerOfferDetail(
                                              offer: e,
                                            )));
                              },
                              child: Card(
                                child: SizedBox(
                                  height: 70.0,
                                  child: 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      
                                       Row(
                                         children: const [
                                          SizedBox(width: 15,),
                                           Icon(Icons.local_offer),
                                         ],
                                       ),
                                       Text(e.accepted,style:const  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                       ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color.fromARGB(
                                                              255, 15, 23, 43)),
                                                  // shape: MaterialStateProperty.all(
                                                  //     RoundedRectangleBorder(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(25),
                                                  // ))
                                                  ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FarmerOfferDetail(
                                                              offer: e,
                                                            )));

                                                // if(e.accepted == 'accepted'){
                                                //  PaymentModel offerModel = PaymentModel(amount: e.quantity.toString(), currency: 'ETB', email: 'gg@gmail.com', firstName: e.orderBy.firstName, lastName: e.orderBy.lastName, phoneNumber:"0986557047", txtRef: 'chewatatest', callbackUrl: "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60", customization: ['teff','Thank you']);

                                                // } else{
                                                //    Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerOfferDetail(offer: e,)));
                                                // }
                                              },
                                              child: const Text("View Detail")),
                                    ],
                                  )
                                  
                                  // ListTile(
                                  //     leading: const Icon(Icons.local_offer),
                                  //     title: Text(e.offeredProduct.name),
                                  //     trailing: Row(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       children: [
                                  //         Text("Pending"),
                                  //         SizedBox(width: 20,),
                                  //         ElevatedButton(
                                  //             style: ButtonStyle(
                                  //                 backgroundColor:
                                  //                     MaterialStateProperty.all(
                                  //                         const Color.fromARGB(
                                  //                             255, 15, 23, 43)),
                                  //                 // shape: MaterialStateProperty.all(
                                  //                 //     RoundedRectangleBorder(
                                  //                 //   borderRadius:
                                  //                 //       BorderRadius.circular(25),
                                  //                 // ))
                                  //                 ),
                                  //             onPressed: () {
                                  //               Navigator.push(
                                  //                   context,
                                  //                   MaterialPageRoute(
                                  //                       builder: (context) =>
                                  //                           FarmerOfferDetail(
                                  //                             offer: e,
                                  //                           )));

                                  //               // if(e.accepted == 'accepted'){
                                  //               //  PaymentModel offerModel = PaymentModel(amount: e.quantity.toString(), currency: 'ETB', email: 'gg@gmail.com', firstName: e.orderBy.firstName, lastName: e.orderBy.lastName, phoneNumber:"0986557047", txtRef: 'chewatatest', callbackUrl: "https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60", customization: ['teff','Thank you']);

                                  //               // } else{
                                  //               //    Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerOfferDetail(offer: e,)));
                                  //               // }
                                  //             },
                                  //             child: const Text("View Detail")),
                                  //       ],
                                  //     )
                                  //     ),
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
