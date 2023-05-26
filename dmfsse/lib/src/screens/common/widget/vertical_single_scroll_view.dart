import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/product.dart';
import '../../../service/firebase_service.dart';
import '../../login_screen.dart';
import 'product_detail.dart';

class VerticalScrollerProduct extends StatefulWidget {
  const VerticalScrollerProduct(
      {super.key, required this.products, required this.searchTerm});
  final List<Product> products;
  final String searchTerm;
  @override
  State<VerticalScrollerProduct> createState() =>
      _VerticalScrollerProductState();
}

class _VerticalScrollerProductState extends State<VerticalScrollerProduct> {
  String? imageUrl;
  List<Product> listOfProduct = [];

  @override
  void initState() {
    widget.products.sort(((a, b) => a.createdAt.toString().compareTo(b.createdAt.toString())));
    listOfProduct = widget.products
        .where((element) =>
            element.name
                .toLowerCase()
                .contains(widget.searchTerm.toLowerCase().toString()) ||
            element.price
                .toInt()
                .toString()
                .contains(widget.searchTerm.toLowerCase().toString()))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          // padding: const EdgeInsets.symmetric(
          //     horizontal: 20.0, vertical: 20.0),
          child: listOfProduct.isEmpty
              ? const Center(child: Text("No Product"))
              : Column(
                  children: listOfProduct
                      .map(
                        (product) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetail(product: product)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12)),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 100.0,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      height: 75.0,
                                      width: 75.0,
                                      imageUrl: product.photo.toString(),
                                      imageBuilder:
                                          (context, imageProvider) =>
                                              Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            4,
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            4,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: SpinKitCircle(
                                        color: Colors.black,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),

                                    const SizedBox(
                                      width: 20,
                                    ),
                                     Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                      const  SizedBox(height: 20,),
                                         SizedBox(
                                              child: Text(
                                                product.name,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                "${product.price.toString()} ETB",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                               
                                                 ElevatedButton(onPressed: (){
                                                  Navigator.pushNamed(context, LoginScreen.routeName);
                                                 }, child: const  Text("Add To Cart"))
                                              ],
                                          
                                            ),
                                            
                                       ],
                                     ),
                                    const  SizedBox(width: 30,),
                                   const  Padding(
                                       padding:  EdgeInsets.only(right: 0.0),
                                       child:  Text('2023'),
                                     )
                                    
                                  
                                  ],
                                )),
                              ),
                            ),
                          ))
                      .toList())),
    );
  }
}
