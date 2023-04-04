import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/product.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/homepage/product_detail';
  final Product product;

  const ProductDetail({required this.product, super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product Detail"),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 15.0,
                // ),
                FutureBuilder(
                    future: FirebaseTaskManager.getImage(
                        widget.product.photos.toString(), 'product', 7),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          imageUrl = snapshot.data as String;
                          return CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: snapshot.data.toString(),
                            // imageUrl: snapshot.data,
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width * 4,
                              height: MediaQuery.of(context).size.height * 4,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: SpinKitCircle(
                              color: Colors.black,
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        }
                      }
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return Column(
                      //     children: const [
                      //       Text("Loading ..."),
                      //       Expanded(
                      //           child: SpinKitCircle(
                      //         color: Colors.black,
                      //       )),
                      //     ],
                      //   );
                      // }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.title,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(widget.product.title.toString())
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.price_change,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(widget.product.price.toString())
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.description,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(widget.product.description.toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
