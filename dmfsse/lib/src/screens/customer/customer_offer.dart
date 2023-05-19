import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../bloc/offer/offer_event.dart';
import '../../bloc/offer/offer_state.dart';
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
    return Column(
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
                                      leading: const Icon(Icons.local_offer),
                                      title: Text(e.offeredProduct.name),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CustomerOfferUpdate(
                                                              offer: e,
                                                            )));
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: const Text(
                                                        "Offer Deleted"),
                                                    content: const Text(
                                                        "Do you want to delete Offer?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child:
                                                              const Text("Yes"),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.delete))
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
    );
  }
}
