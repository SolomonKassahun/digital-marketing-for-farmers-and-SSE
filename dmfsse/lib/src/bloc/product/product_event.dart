import '../../models/product.dart';

class ProductEvent {}
class AddProduct extends ProductEvent{
  Product product;
  AddProduct(this.product);
  
}
class FetchAllProduct extends ProductEvent {}
class UpdateProduct extends ProductEvent {
  int  ProductId;
  UpdateProduct(this.ProductId);
}
class DeleteProduct extends ProductEvent {
  int ProductId;
  DeleteProduct(this.ProductId);
}