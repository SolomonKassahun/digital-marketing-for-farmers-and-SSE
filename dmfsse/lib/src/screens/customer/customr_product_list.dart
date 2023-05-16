import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/product.dart';
import '../../service/firebase_service.dart';
import '../auth/fireabase_verification_screen.dart';
import 'customer_offer_room.dart';
import 'customer_product_detail.dart';

class CustomerProductList extends StatefulWidget {
  final List<Product> products;
  final String searchTerm;
  const CustomerProductList(
      {required this.products, required this.searchTerm, super.key});

  @override
  State<CustomerProductList> createState() => _CustomerProductListState();
}

class _CustomerProductListState extends State<CustomerProductList> {
  String? imageUrl;
  List<Product> listOfProduct = [];

  @override
  void initState() {
    listOfProduct = widget.products
        .where((element) =>
            element.name
                .toLowerCase()
                .contains(widget.searchTerm.toLowerCase().toString()) ||
            element.price
                .toInt()
                .toString()
                .contains(widget.searchTerm.toLowerCase().toString()))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          // padding: const EdgeInsets.symmetric(
          //     horizontal: 20.0, vertical: 20.0),
          child: listOfProduct.isEmpty
              ? const Center(child: Text("No Product"))
              : Column(
                  children: listOfProduct
                      .map((product) => Container(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomrProductDetail(
                                                product: product)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: SizedBox(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        height: 75.0,
                                                        width: 75.0,
                                                        imageUrl: product.photo.toString(),
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
                                                                .rectangle,
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
                                                          color: Colors.black,
                                                        )),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                            // FutureBuilder(
                                            //     future: FirebaseTaskManager
                                            //         .getImage(
                                            //             product.photo
                                            //                 .toString(),
                                            //             'product',
                                            //             7),
                                            //     builder: (BuildContext context,
                                            //         AsyncSnapshot<dynamic>
                                            //             snapshot) {
                                            //       switch (snapshot
                                            //           .connectionState) {
                                            //         case ConnectionState.none:
                                            //           return const Text('none');
                                            //         case ConnectionState
                                            //             .waiting:
                                            //           return Center(
                                            //               child: Column(
                                            //             children: const [
                                            //               Text("Loading ..."),
                                            //               Expanded(
                                            //                   child:
                                            //                       SpinKitCircle(
                                            //                 color: Colors.black,
                                            //               )),
                                            //             ],
                                            //           ));
                                            //         case ConnectionState.active:
                                            //           return const Text(
                                            //               'Loading...');
                                            //         case ConnectionState.done:
                                            //           imageUrl = snapshot.data;

                                            //           return CachedNetworkImage(
                                            //             fit: BoxFit.fill,
                                            //             height: 75.0,
                                            //             width: 75.0,
                                            //             imageUrl: snapshot.data,
                                            //             imageBuilder: (context,
                                            //                     imageProvider) =>
                                            //                 Container(
                                            //               width: MediaQuery.of(
                                            //                           context)
                                            //                       .size
                                            //                       .width *
                                            //                   4,
                                            //               height: MediaQuery.of(
                                            //                           context)
                                            //                       .size
                                            //                       .height *
                                            //                   4,
                                            //               decoration:
                                            //                   BoxDecoration(
                                            //                 shape: BoxShape
                                            //                     .rectangle,
                                            //                 image: DecorationImage(
                                            //                     image:
                                            //                         imageProvider,
                                            //                     fit: BoxFit
                                            //                         .cover),
                                            //               ),
                                            //             ),
                                            //             placeholder: (context,
                                            //                     url) =>
                                            //                 const Center(
                                            //                     child:
                                            //                         SpinKitCircle(
                                            //               color: Colors.black,
                                            //             )),
                                            //             errorWidget: (context,
                                            //                     url, error) =>
                                            //                 const Icon(
                                            //                     Icons.error),
                                            //           );
                                            //       }
                                            //     }),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  child: Text(
                                                    product.name,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    "${product.price} Birr",
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                           
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomerOfferRoom(
                                                          product: product,
                                                        )));
                                          },
                                          child: const Text("Buy product"),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList())),
    );
  }
}
