import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/src/bloc/offer/offer_bloc.dart';
import 'package:dmfsse/src/bloc/offer/offer_state.dart';
import 'package:dmfsse/src/models/offer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../generated/locale_keys.g.dart';

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
        backgroundColor: const  Color.fromARGB(255, 15, 23, 43),
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
                const  Text(
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
                    CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 40.0,

                                                          width: 40,

                                                          imageUrl: widget.offer.offeredProduct.photo,
                                                          // imageUrl: snapshot.data,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                4,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                4,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              const Center(
                                                                  child:
                                                                      SpinKitCircle(
                                                            color: Colors.blue,
                                                          )),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.person),
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
                 Text(
                   LocaleKeys.requestdDetialText.tr(),
                  style:  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                     Text(
                      "${LocaleKeys.quantityText.tr()}:   ",
                      style: const TextStyle(color: Colors.black38),
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
                     Text(
                      "${LocaleKeys.offerPriceText.tr()}:    ",
                      style: const TextStyle(color: Colors.black38),
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
                 Text(
                  LocaleKeys.productDetailText.tr(),
                  style:const  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                     Text(
                      "${LocaleKeys.productNameText.tr()}:   ",
                      style:const  TextStyle(color: Colors.black38),
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
                     Text(
                      "${LocaleKeys.productpriceText.tr()}:    ",
                      style: const  TextStyle(color: Colors.black38),
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
