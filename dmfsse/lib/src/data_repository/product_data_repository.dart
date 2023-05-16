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
 
  List<Product> listOfProduct= await productDataProvider.getAllActiveProduct();
  return listOfProduct;

}
Future<List<Product>> getMyProduct() async{
 
  List<Product> listOfProduct= await productDataProvider.getMyProduct();
  return listOfProduct;

}
Future<Product> updateProduct(String id) async {
  return productDataProvider.updateProducct(id);
}
Future<bool> deleteProduct(String id) async {
  return productDataProvider.deleteProduct(id);
}
}