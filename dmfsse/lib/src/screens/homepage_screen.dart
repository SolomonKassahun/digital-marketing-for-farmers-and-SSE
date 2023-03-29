import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/src/bloc/product/product_bloc.dart';
import 'package:dmfsse/src/bloc/product/product_event.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../service/firebase_service.dart';
import 'common/widget/HorizontalSingleScrollVIew.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/";
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ProductBloc fetchBloc;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    // fetchBloc = BlocProvider.of<ProductBloc>(context);
    // fetchBloc.add(FetchAllProduct());
    BlocProvider.of<ProductBloc>(context).add(FetchAllProduct());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 25),
        // scrollDirection: Axis.vertical,
        child: BlocBuilder<ProductBloc, ProductState>(
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
              return Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                    Container(
                    height: 80,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                  const HorizontalSingleScrollVIew(),
                 const  SizedBox(height: 15,),
                
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    child: Container(
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 20.0, vertical: 20.0),
                        child: state.product.isEmpty
                            ? const Center(child: Text("No Product"))
                            : Column(
                                children: state.product
                                    .map((product) => Container(
                                      padding: const  EdgeInsets.all(10),
                                      child: Card(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 90.0,
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  FutureBuilder(
                                                      future: FirebaseTaskManager
                                                          .getImage(
                                                              product.photos
                                                                  .toString(),
                                                              'product',
                                                              7),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                            return const Text(
                                                                'none');
                                                          case ConnectionState
                                                              .waiting:
                                                            return Center(
                                                                child: Column(
                                                              children: const [
                                                                Text(
                                                                    "Loading ..."),
                                                                Expanded(
                                                                    child:
                                                                        SpinKitCircle(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                              ],
                                                            ));
                                                          case ConnectionState
                                                              .active:
                                                            return const Text(
                                                                'Loading...');
                                                          case ConnectionState
                                                              .done:
                                                            imageUrl =
                                                                snapshot.data;
                                    
                                                            return CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              height: 50.0,
                                                              width: 50.0,
                                                              imageUrl:
                                                                  snapshot.data,
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
                                                                color:
                                                                    Colors.white,
                                                              )),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            );
                                                        }
                                                      }),
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        '${product.title}',
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                      Text(
                                                        "${product.description}",
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                            ),
                                          ),
                                    ))
                                    .toList())),
                  ),
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
            child: const Text("Log in"),
          )),
    );
  }
}
