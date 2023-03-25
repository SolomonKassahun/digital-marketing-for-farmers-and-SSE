import 'package:dmfsse/src/bloc/product/product_bloc.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/models/product.dart';
import 'package:dmfsse/src/screens/farmer/add_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is AddProductLoading) {
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        }
        if (state is AddProductSucess) {
          return const Center(
            child: Text("Product Added Successfully"),
          );
        }
        if (state is AddProductFailure) {
          return const Center(
            child: Text("Unable to addd product "),
          );
        }
        return const SizedBox();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 120,
        height: 45,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddProductDetail.routeName);
          },

          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: const Text("Add Product"),

          // Container(
          //   width: 200,
          //   height: 40,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(100),
          //   ),
          //   child: ElevatedButton(
          //       onPressed: () {
          // Navigator.pushNamed(context, AddProductDetail.routeName);
          //         // print("add product clicked");

          //         // Product product = Product();
          //         // product.title = 'Getacheew';
          //         // product.description = "Getachew K";
          //         // product.price = '2000';
          //         // product.photos = '/desktoop/solomn';
          //         // AddProduct addProduct = AddProduct(product);
          //         // BlocProvider.of<ProductBloc>(context).add(addProduct);
          //       },
          //       style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all(Colors.blue),
          //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(25),
          //           ))),
          //       child: const Text("Add Product")),
          // ),
        ),
      ),
    );
  }
}
