import 'package:dmfsse/src/screens/common/widget/search_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_state.dart';
import 'HorizontalSingleScrollVIew.dart';
import 'verticalSingleScrollView.dart';

class ListOfProduct extends StatefulWidget {
  const ListOfProduct({super.key});

  @override
  State<ListOfProduct> createState() => _ListOfProductState();
}

class _ListOfProductState extends State<ListOfProduct> {
  TextEditingController searchController = TextEditingController();
  String searchTerm = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      // scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            SearchFilterButton(
              searchController: searchController,
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
            ),
            const SizedBox(
              height: 35,
            ),
            BlocBuilder<ProductBloc, ProductState>(
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
                  // searcheProduct = listOfProduct.where((element) => searchController.text == ).toList
                  return Column(
                    children: [
                      const HorizontalSingleScrollVIew(),
                      const SizedBox(
                        height: 20,
                      ),
                      VerticalScrollerProduct(
                          products: state.product, searchTerm: searchTerm),
                    ],
                  );
                }
                if (state is FetchAllProductFailure) {
                  return const Center(child: Text("No Connection"));
                }
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              },
              // child:  Center(
              //   child:  Text('Homepage'),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
