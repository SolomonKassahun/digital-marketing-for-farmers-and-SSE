import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_state.dart';
import '../../../service/firebase_service.dart';

class HorizontalSingleScrollVIew extends StatefulWidget {
  const HorizontalSingleScrollVIew({super.key});

  @override
  State<HorizontalSingleScrollVIew> createState() =>
      _HorizontalSingleScrollVIewState();
}

class _HorizontalSingleScrollVIewState
    extends State<HorizontalSingleScrollVIew> {
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is InitialState) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }
        if (state is FetchAllProductLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }
        if (state is FetchAllProductSucess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                child: state.product.isEmpty
                    ? const Center(child: Text("No Product"))
                    : Row(
                        children: state.product
                            .map(
                              (product) => Row(
                                children: [
                                  Stack(children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: FutureBuilder(
                                          future: FirebaseTaskManager.getImage(
                                              product.photo.toString(),
                                              'product',
                                              7),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                return const Text('none');
                                              case ConnectionState.waiting:
                                                return Center(
                                                    child: Column(
                                                  children: const [
                                                    Text("Loading ..."),
                                                    Expanded(
                                                        child: SpinKitCircle(
                                                      color: Colors.black,
                                                    )),
                                                  ],
                                                ));
                                              case ConnectionState.active:
                                                return const Text('Loading...');
                                              case ConnectionState.done:
                                                imageUrl = snapshot.data;
                                                if (snapshot.hasError) {
                                                  return const Text(
                                                      "No Connection");
                                                }
                                                return CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  height: 75.0,
                                                  width: 75.0,
                                                  imageUrl: snapshot.data,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            4,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child: SpinKitCircle(
                                                    color: Colors.black,
                                                  )),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                );
                                            }
                                          }),
                                      // child: Stack(
                                      //   children: [
                                      //     CachedNetworkImage(
                                      //         imageUrl:
                                      //             FirebaseTaskManager.getImage(
                                      //                     product.photos.toString(),
                                      //                     'product',
                                      //                     7)
                                      //                 .toString()),
                                      //     Text(product.title.toString())
                                      //   ],
                                      // ),
                                    ),
                                    Positioned(
                                        left: 25,
                                        top: 30,
                                        child: Text(
                                          product.name.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ))
                                  ]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )
                            .toList())),
          );
        }
        if (state is FetchAllProductFailure) {
          return const Text("No Connection");
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
      // child:  Center(
      //   child:  Text('Homepage'),
      // ),
    );
  }
}
