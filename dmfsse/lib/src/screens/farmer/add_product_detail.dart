import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../../models/product.dart';
import '../common/widget/input_field.dart';
import '../common/widget/upload_image.dart';
import '../homepage_screen.dart';
import 'farmer_homepage.dart';

class AddProductDetail extends StatefulWidget {
  static const routeName = "/addProductDetail";
  const AddProductDetail({super.key});

  @override
  State<AddProductDetail> createState() => _AddProductDetailState();
}

class _AddProductDetailState extends State<AddProductDetail> {
  final _formKey = GlobalKey<FormState>();
  bool isRegister = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productPhotos = TextEditingController();
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(children: [
        // TextSpan(
        //   text: 'Add Your Product\n \n',
        //   style: TextStyle(color: Colors.white, fontSize: 25),
        // ),
        TextSpan(
          text: 'Create and Sell Your product',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Product Detail"),
          backgroundColor: Colors.blue),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              _title(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  // ignore: prefer_const_constructors
                  child: BlocConsumer<ProductBloc, ProductState>(
                      listener: (context, state) {
                    // if(state is AddProductLoading) {
                    //   isRegister = true;
                    // }
                    if (state is AddProductSucess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FarmerHomepage()));
                    }
                  }, builder: (context, state) {
                    if (state is AddProductLoading) {
                      isRegister = true;
                    }
                    if (state is AddProductFailure) {
                      isRegister = false;
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Title",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              //  InputTextFormField(),
                              InputTextFormField(
                                hintTxt: 'Title',
                                controller: titleController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.text,
                                errorMessage: "product title",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              InputTextFormField(
                                hintTxt: 'Price',
                                controller: priceController,
                                isRequired: false,
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "product price",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  maxLines: 6,
                                  onChanged: (value) {
                                    descriptionController.text = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'description about product',
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      // borderSide: BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                    // contentPadding: const EdgeInsets.only(
                                    //   top: 6,
                                    //   bottom: 6,
                                    //   left: 12,
                                    // ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Add Product Photo",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Center(
                                child: UploadImage(pickImage: (image) {
                                  setState(() {
                                    productPhotos.text = image.path;
                                  });
                                }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      print("add product clicked");

                                      Product product = Product();
                                      product.title =
                                          titleController.text.toString();
                                      product.description =
                                          descriptionController.text.toString();
                                      product.price =
                                          int.parse(priceController.text);
                                      product.photos =
                                          productPhotos.text.toString();
                                      print("======================");
                                      print(
                                          '${productPhotos.text},${titleController.text}');
                                      AddProduct addProduct =
                                          AddProduct(product);
                                      BlocProvider.of<ProductBloc>(context)
                                          .add(addProduct);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ))),
                                    child: isRegister
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Add Product")),
                              ),
                            ],
                          )),

                      // children: [
                      // Center(
                      //   child: UploadImage(pickImage: (image) {
                      //     setState(() {
                      //       // photoController.text = image.path;
                      //     });
                      //   }),
                      // ),
                      //   TextFormField(),
                      //   TextFormField(),
                      //   TextFormField(),
                      //   TextFormField(),
                      // ],
                    );
                  }),
                ),
              ),
            ],
          )),
    );
  }
}
