import '../../models/product.dart';

class ProductEvent {}
class AddProduct extends ProductEvent{
  Product product;
  AddProduct(this.product);
  
}
class FetchAllProduct extends ProductEvent {}
class UpdateProduct extends ProductEvent {
  Product  product;
  UpdateProduct(this.product);
}
class FetchMyProduct extends ProductEvent{
  
}
class DeleteProduct extends ProductEvent {
  String productId;
  DeleteProduct(this.productId);
}