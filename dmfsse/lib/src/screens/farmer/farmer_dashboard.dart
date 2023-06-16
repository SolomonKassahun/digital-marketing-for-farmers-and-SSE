import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/locale_keys.g.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_state.dart';

import '../common/widget/horizontal_single_scroll_view.dart';
import '../common/widget/search_filter_button.dart';
import 'farmer_product_list.dart';


class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
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
             Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchTerm = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 228, 225, 225))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(228, 225, 225, 1))),
                    hintText: LocaleKeys.searchText.tr(),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 112, 110, 110)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 228, 225, 225),
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 228, 225, 225))),
                  ),
                ),
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
                      FarmerProductList(
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
