import 'package:dmfsse/src/data_provider/product_data_provider.dart';
import 'package:dmfsse/src/models/product.dart';

class ProductDataRepository {
  final ProductDataProvider productDataProvider;
  ProductDataRepository(this.productDataProvider);

Future<bool> addProduct(Product product) async{
  // print('the values at repo is ${productDataProvider.addProduct(product)}');
  var r =  await (productDataProvider.addProduct(product));
  return r;
}
Future<List<Product>> getAllActiveProduct() async{
  print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
  List<Product> listOfProduct= await productDataProvider.getAllActiveProduct();
  print(listOfProduct);
  print("RRRRRRRRRRRRRRRRRRRRRRRRRRRR");
  return listOfProduct;

}
}