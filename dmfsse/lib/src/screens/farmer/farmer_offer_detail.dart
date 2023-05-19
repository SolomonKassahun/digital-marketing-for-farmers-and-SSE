import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:dmfsse/src/bloc/offer/offer_event.dart';
import 'package:dmfsse/src/bloc/offer/offer_state.dart';
import 'package:dmfsse/src/models/offer.dart';
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
        title: Text(widget.offer.offeredProduct.name.toString()),
      ),
      body: BlocBuilder<OfferBloc, OfferState>(
        
        builder: (context, state) {
          if(state is OfferStateLoading){
            isOfferAccepted = true;
          }
          else{
            isOfferAccepted = false;
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
                        onPressed: () {
                          OfferUpdateData offerUpdateData = OfferUpdateData(accepted: true, canRate: widget.offer.canRate, quantity: widget.offer.quantity, offerPrice: widget.offer.offerPrice);
                          AcceptOfferEvent acceptOfferEvent = AcceptOfferEvent(offer: offerUpdateData);
                          BlocProvider.of<OfferBloc>(context).add(acceptOfferEvent);
                        }, child: const Text("Accept Offer")),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Reject Offer"))
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
