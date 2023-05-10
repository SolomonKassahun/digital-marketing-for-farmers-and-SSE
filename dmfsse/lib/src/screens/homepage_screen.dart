import 'package:dmfsse/src/bloc/product/product_bloc.dart';
import 'package:dmfsse/src/bloc/product/product_event.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/widget/horizontal_single_scroll_view.dart';
import 'common/widget/search_filter_button.dart';
import 'common/widget/vertical_single_scroll_view.dart';
import 'package:dmfsse/generated/locale_keys.g.dart';

class Homepage extends StatefulWidget {
  static const routeName = "/homepage";
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ProductBloc fetchBloc;
  TextEditingController searchController = TextEditingController();
  String? imageUrl;
  String searchTerm = "";
  String _initialValue = "en";

  @override
  Widget build(BuildContext context) {
    // fetchBloc = BlocProvider.of<ProductBloc>(context);
    // fetchBloc.add(FetchAllProduct());
    BlocProvider.of<ProductBloc>(context).add(FetchAllProduct());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        // scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SearchFilterButton(
                    searchController: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchTerm = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 50,
                    child: DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                          value: 'am',
                          child: Text(
                            'አማ',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        DropdownMenuItem(
                            value: 'en',
                            child: Text(
                              "EN",
                              style: TextStyle(color: Colors.blue),
                            )),
                        DropdownMenuItem(
                          value: "oro",
                          child: Text(
                            "Oro",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                      value: _initialValue,
                      onChanged: (value) async {
                        setState(() {
                          _initialValue = value.toString();
                        });
                        await context.setLocale(Locale(value.toString()));
                      },
                    ),
                  )
                ],
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: 120,
          height: 45,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Text(LocaleKeys.loginText.tr()),
          )),
    );
  }
}
