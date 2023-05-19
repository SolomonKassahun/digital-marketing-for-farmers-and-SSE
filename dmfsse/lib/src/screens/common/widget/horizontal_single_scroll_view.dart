import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_state.dart';
import '../../../service/firebase_service.dart';

class HorizontalSingleScrollView extends StatefulWidget {
  const HorizontalSingleScrollView({super.key});

  @override
  State<HorizontalSingleScrollView> createState() =>
      _HorizontalSingleScrollViewState();
}

class _HorizontalSingleScrollViewState
    extends State<HorizontalSingleScrollView> {
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
                    ? const SizedBox.shrink()
                    : Row(
                        children: state.product
                            .map(
                              (product) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: 
                                     
                                      CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  height: 75.0,
                                                  width: 75.0,
                                                  imageUrl: product.photo.toString(),
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
                                                ),

                                      
                                    ),
                                    Text(
                                      product.name.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
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
