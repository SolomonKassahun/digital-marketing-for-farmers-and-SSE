import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:dmfsse/src/bloc/offer/offer_event.dart';
import 'package:dmfsse/src/bloc/offer/offer_state.dart';
import 'package:dmfsse/src/models/offer.dart';
import 'package:dmfsse/src/screens/farmer/farmer_homepage.dart';
import 'package:dmfsse/src/screens/farmer/farmer_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmerOfferDetail extends StatefulWidget {
  final Offer offer;
  const FarmerOfferDetail({required this.offer, super.key});

  @override
  State<FarmerOfferDetail> createState() => _FarmerOfferDetailState();
}

class _FarmerOfferDetailState extends State<FarmerOfferDetail> {
  bool isOfferAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const  Color.fromARGB(255, 15, 23, 43),
        title: Text(widget.offer.offeredProduct.name.toString()),
      ),
      body: BlocConsumer<OfferBloc, OfferState>(
        listener: (context, state) {
          if (state is OfferStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to accept Offer")));
          }
          if (state is OfferAcceptStateSucess) {
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const FarmerHomepage()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is OfferStateLoading) {
            isOfferAccepted = true;
          } else {
            isOfferAccepted = false;
          }
          if (state is OfferStateLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 5,
                ),
                const Text(
                  "Customer",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/drawerPP.jpg'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.offer.orderBy.firstName} ${widget.offer.orderBy.lastName}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.offer.createdAt.toString())
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Request Detail",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Quantity:   ",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      widget.offer.quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "Offer Price:    ",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      widget.offer.offerPrice.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "Status:    ",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      widget.offer.accepted.toString().toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Product Detail",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Product Name:   ",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      widget.offer.offeredProduct.name.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "Product Price:    ",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      widget.offer.offeredProduct.price.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 15, 23, 43),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ))),
                        onPressed: () {
                          OfferUpdateData offerUpdateData = OfferUpdateData(
                              offerId: widget.offer.id,
                              accepted: "accepted",
                              canRate: widget.offer.canRate,
                              quantity: widget.offer.quantity,
                              offerPrice: widget.offer.offerPrice);
                          AcceptOfferEvent acceptOfferEvent =
                              AcceptOfferEvent(offer: offerUpdateData);
                          BlocProvider.of<OfferBloc>(context)
                              .add(acceptOfferEvent);
                        },
                        child: isOfferAccepted
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Accept Offer")),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 15, 23, 43),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ))),
                        onPressed: () {
                          OfferUpdateData offerUpdateData = OfferUpdateData(
                              offerId: widget.offer.id,
                              accepted: "rejected",
                              canRate: widget.offer.canRate,
                              quantity: widget.offer.quantity,
                              offerPrice: widget.offer.offerPrice);
                          AcceptOfferEvent acceptOfferEvent =
                              AcceptOfferEvent(offer: offerUpdateData);
                          BlocProvider.of<OfferBloc>(context)
                              .add(acceptOfferEvent);
                        },
                        child: isOfferAccepted
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Reject Offer"))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
