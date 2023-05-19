import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:dmfsse/src/bloc/offer/offer_state.dart';
import 'package:dmfsse/src/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOfferDetail extends StatefulWidget {
  final Offer offer;
  const CustomerOfferDetail({required this.offer, super.key});

  @override
  State<CustomerOfferDetail> createState() => _CustomerOfferDetailState();
}

class _CustomerOfferDetailState extends State<CustomerOfferDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer.offeredProduct.name.toString()),
      ),
      body: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
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
                  "You",
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
               
              ],
            ),
          );
        },
      ),
    );
  }
}
