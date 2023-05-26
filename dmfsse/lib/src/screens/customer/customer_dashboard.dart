import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_state.dart';

import '../common/widget/horizontal_single_scroll_view.dart';
import '../common/widget/search_filter_button.dart';
import 'customr_product_list.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  TextEditingController searchController = TextEditingController();
  String searchTerm = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HorizontalSingleScrollView(),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomerProductList(
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
      ),
    );
  }
}
