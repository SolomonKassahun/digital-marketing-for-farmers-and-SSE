import 'package:dmfsse/src/bloc/product/product_bloc.dart';
import 'package:dmfsse/src/bloc/product/product_event.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/models/product.dart';
import 'package:dmfsse/src/screens/farmer/add_product_detail.dart';
import 'package:dmfsse/src/screens/farmer/product_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchMyProduct());
    return
        // Scaffold(
        //   body:
        Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Your Product",
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is FetchMyProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is FetchMyProductSucess) {
              return SingleChildScrollView(
                child: Container(
                    child: state.product.isEmpty
                        ? const Center(
                            child: Text("You didn't have any product"),
                          )
                        : Column(
                            children: state.product
                                .map((e) => Card(
                                      child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: const Icon(Icons
                                                .production_quantity_limits),
                                            title: Text(e.name),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  ProductUpdate(
                                                                    product: e,
                                                                  ))));
                                                    },
                                                    icon:
                                                        const Icon(Icons.edit)),
                                                IconButton(
                                                    onPressed: () {
                                                       showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: const Text(
                                                        "Product Deleted"),
                                                    content: const Text(
                                                        "Do you want to delete product?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child:
                                                              const Text("Yes"),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14),
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete)),
                                              ],
                                            ),
                                          )),
                                    ))
                                .toList())),
              );
            } 
            if(state is FetchAllProductFailure) {
              return const Center(
                child: Text("Unable to Load product "),
              );
            }
            return const  Center(child:  CircularProgressIndicator(color: Colors.black,));
          }),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductDetail.routeName);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
              child: const Text("Add Product")),
        ),
      )
    ]);
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // floatingActionButton: SizedBox(
    //   width: 120,
    //   height: 45,
    //   child: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, AddProductDetail.routeName);
    //     },

    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(25.0))),
    //     child: const Text("Add Product"),

    //   Container(
    //     width: 200,
    //     height: 40,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100),
    //     ),
    //     child: ElevatedButton(
    //         onPressed: () {
    //   Navigator.pushNamed(context, AddProductDetail.routeName);
    //           // print("add product clicked");

    //           // Product product = Product();
    //           // product.title = 'Getacheew';
    //           // product.description = "Getachew K";
    //           // product.price = '2000';
    //           // product.photos = '/desktoop/solomn';
    //           // AddProduct addProduct = AddProduct(product);
    //           // BlocProvider.of<ProductBloc>(context).add(addProduct);
    //         },
    //         style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.all(Colors.blue),
    //             shape: MaterialStateProperty.all(RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(25),
    //             ))),
    //         child: const Text("Add Product")),
    //   ),
    // ),
    //   ),
    // );
  }
}
