
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
  State<HorizontalSingleScrollVIew> createState() => _HorizontalSingleScrollVIewState();
}

class _HorizontalSingleScrollVIewState extends State<HorizontalSingleScrollVIew> {
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
              return 
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                       
                        child: state.product.isEmpty
                            ? const Center(child: Text("No Vehicles"))
                            : Row(
                                children: state.product
                                    .map((product) =>  Container
                                    (
                                         width: 50,
                                         height: 50,
                                         child: Text('${product.title}'),
                                    )
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