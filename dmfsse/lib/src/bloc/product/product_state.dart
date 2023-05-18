import '../../models/product.dart';

class ProductState {}
class InitialState extends ProductState {}
class FetchAllProductLoading extends ProductState{}
class FetchAllProductSucess extends ProductState {
  final List<Product> product;
  FetchAllProductSucess({required this.product});

}
class FetchMyProductLoading extends ProductState{}

class FetchMyProductSucess extends ProductState {
  final List<Product> product;
  FetchMyProductSucess({required this.product});

}

class FetchAllProductFailure extends ProductState {
  final String message;
  FetchAllProductFailure({required this.message});

}
class AddProductLoading extends ProductState {}
class AddProductSucess extends ProductState {
  
}
class AddProductFailure extends ProductState {}
class UpdateProductLoading extends ProductState {}
class UpdateProductSucess extends ProductState {}
class UpdateProductFailure extends ProductState {}
class DeleteProductLoading extends ProductState {}
class DeleteProductSucess extends ProductState {}
class DeleteProductFailure extends ProductState {}