

import 'package:dmfsse/src/bloc/product/product_bloc.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_event.dart';
import '../../models/product.dart';
import '../common/widget/input_field.dart';
import '../common/widget/product_form.dart';

class ProductUpdate extends StatefulWidget {
  final Product product;
  const ProductUpdate({required this.product, super.key});

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  final formKey = GlobalKey<FormState>();
  bool isUpdate = false;

Map<String, dynamic> productBody = {};
    

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
        title:   Text(widget.product.name.toString(),style: const TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: const Color.fromARGB(255, 15, 23, 43),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             const SizedBox(
                height: 35,
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
                  child: BlocConsumer<ProductBloc,ProductState>(
                    listener: ((context, state) {
                     if (state is FetchAllProductSucess){
                      Navigator.pop(context);
                     }
                     if(state is FetchAllProductFailure){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Failed to update product")));
                     }
                    }),
                    builder: ((context, state) {
                       if(state is InitialState){
                        isUpdate = true;
                      }
                     else{
                      isUpdate = false;
                     }
                      return SingleChildScrollView(
                             scrollDirection: Axis.vertical,
                             child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   const Text(
                                "Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 15, 23, 43)),
                              ),
                                const SizedBox(
                                height: 10,
                              ),
                              //  InputTextFormField(),
                              ProductTextFormField(
                                
                                onSaved: (value){
                                  productBody['name'] = value;
                                },
                                initialValue: widget.product.name,
                                
                                onChanged: (String value) {},
                                keyboardType: TextInputType.text,
                                errorMessage: "product name",
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter product name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                                 const Text(
                                "Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 15, 23, 43)),
                              ),
                                const SizedBox(
                                height: 10,
                              ),
                              //  InputTextFormField(),
                              ProductTextFormField(
                                
                                onSaved: (value){
                                  productBody['price'] = value;
                                },
                                initialValue: widget.product.price.toString(),
                                
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "product price",
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter product price";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                               const Text(
                                "Amount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 15, 23, 43)),
                              ),
                                const SizedBox(
                                height: 10,
                              ),
                              //  InputTextFormField(),
                              ProductTextFormField(
                                
                                onSaved: (value){
                                  productBody['amount'] = value;
                                },
                                initialValue: widget.product.amount.toString(),
                                
                                onChanged: (String value) {},
                                keyboardType: TextInputType.number,
                                errorMessage: "product amount",
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter product amount";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                             
                                const Text(
                                "Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 15, 23, 43)),
                              ),
                                const SizedBox(
                                height: 10,
                              ),
                              //  InputTextFormField(),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: TextFormField(
                                  maxLines: 6,
                                  onChanged: (value) {
                                   
                                  },
                                  onSaved: (value){
                                    productBody['description'] = value;
                                  },
                                  initialValue: widget.product.description,
                                  decoration: InputDecoration(
                                    // labelText: 'description about product',
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      // borderSide: BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                    contentPadding: const EdgeInsets.only(
                                      // top: 6,
                                      bottom: 6,
                                      left: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                      formKey.currentState!.save();
                                      if(formKey.currentState!.validate()){
                                        print(widget.product.id);
                                         Product product = Product(
                                          id: widget.product.id,
                                          name: productBody['name'],
                                           price: int.parse(productBody['price']), 
                                           description: productBody['description'], 
                                           amount: int.parse(productBody['amount']),
                                           photo: widget.product.photo,
                                           soldout: widget.product.soldout,
                                           
                                           );
                                        UpdateProduct updateProduct = UpdateProduct(product);
                                         BlocProvider.of<ProductBloc>(context)
                                            .add(updateProduct);
                                      }
                                       


                                    
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(255, 15, 23, 43)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ))),
                                    child: isUpdate
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text("Update Product")),
                              ),
                                ],
                              )
                             ),
                      );
                      
                    }),
                  ),
                  
                ),
              )
          ],
        ),
        
      )
    );
  }
}