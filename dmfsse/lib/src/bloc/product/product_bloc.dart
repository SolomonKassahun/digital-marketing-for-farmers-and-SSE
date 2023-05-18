import 'package:dmfsse/src/bloc/product/product_event.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/data_repository/product_data_repository.dart';
import 'package:dmfsse/src/models/product.dart';
import 'package:dmfsse/src/screens/common/widget/list_of_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDataRepository productDataRepository;
  ProductBloc(this.productDataRepository) : super(InitialState()) {
    on<ProductEvent>((event, emit) async {
      if (event is AddProduct) {
        try {
          emit(AddProductLoading());
          bool isProductCreated =
              await productDataRepository.addProduct(event.product);

          if (isProductCreated) {
            emit(AddProductSucess());
          } else {
            // ignore: invalid_use_of_visible_for_testing_member
            emit(AddProductFailure());
          }
        } catch (e) {
          throw Exception(e);
        }
      }
      if (event is FetchAllProduct) {
        emit(FetchAllProductLoading());
        try {
          final List<Product> productDetail =
              await productDataRepository.getAllActiveProduct();
        
          if (productDetail != []) {
           
            emit(FetchAllProductSucess(product: productDetail));
          } else {
           
            emit(FetchAllProductFailure(message: "No connection"));
          }
        } catch (e) {
          throw Exception("z e iiss $e");
        }
      }
      if(event is FetchMyProduct){
          emit(FetchMyProductLoading());
        try {
          final List<Product> myProduct =
              await productDataRepository.getMyProduct();
        
          if (myProduct != []) {
           
            emit(FetchMyProductSucess(product: myProduct));
          } else {
           
            emit(FetchAllProductFailure(message: "Failed to load Product."));
          }
        } catch (e) {
          throw Exception("z e iiss $e");
        }
      }
      if(event is UpdateProduct){
        emit (InitialState());
        try {
          Product product = await productDataRepository.updateProduct(event.product);
          List<Product> listOfProduct = await productDataRepository.getAllActiveProduct();
          // ignore: unnecessary_type_check
          if(product is Product && listOfProduct is List<Product>){
             emit (FetchAllProductSucess(product: listOfProduct));
          } else{
            emit(FetchAllProductFailure(message: "Failed to update product"));
          }
          
        } catch (e) {
          emit(FetchAllProductFailure(message: "Failed to update a product"));
        }
      }
      if(event is DeleteProduct){
        emit (InitialState());
        try {
          final product  = await productDataRepository.deleteProduct(event.productId);
          final listOfProduct = await productDataRepository.getAllActiveProduct();
          if(product){
             emit (FetchAllProductSucess(product: listOfProduct));
          } else{
            emit(FetchAllProductFailure(message: "Failed to delete a product"));
          }
        } catch (e) {
          emit(FetchAllProductFailure(message: "Failed to delete a product"));
        }
      }
    });
  }
}
