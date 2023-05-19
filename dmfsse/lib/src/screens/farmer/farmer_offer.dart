import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../bloc/offer/offer_event.dart';
import '../../bloc/offer/offer_state.dart';
import 'farmer_offer_detail.dart';

class FarmerOffer extends StatefulWidget {
  const FarmerOffer({super.key});

  @override
  State<FarmerOffer> createState() => _FarmerOfferState();
}


class _FarmerOfferState extends State<FarmerOffer> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OfferBloc>(context).add(GetMyOfferEvent());
    return Column(
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
                child:  CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if(state is OfferStateFailure){
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
                      .map((e) => GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerOfferDetail(offer: e,)));
                        },
                        child: Card(
                          
                          child: SizedBox(
                            height: 70.0,
                            child: ListTile(
                                  leading: const Icon(Icons.local_offer),
                                  title: Text(e.offeredProduct.name),
                                  trailing: ElevatedButton(onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => FarmerOfferDetail(offer: e,)));
                                  }, child: const Text("View Detail"))
                                 
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
