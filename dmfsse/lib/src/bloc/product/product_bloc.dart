import 'package:dmfsse/src/bloc/product/product_event.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/data_repository/product_data_repository.dart';
import 'package:dmfsse/src/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  final ProductDataRepository productDataRepository;
  ProductBloc(this.productDataRepository):super(InitialState()){
    on<AddProduct>((event, emit) => addProductMapEventToState(event.product));
  }

  void addProductMapEventToState(Product product) async{
    // ignore: invalid_use_of_visible_for_testing_member
    emit(AddProductLoading());
    try {
      bool isProductCreated = await productDataRepository.addProduct(product);
      print("the value of is product created is ${isProductCreated}");
      if(isProductCreated){
          emit(AddProductSucess());
      } else{
         emit(AddProductFailure());
      }
     
    } catch (e) {
       throw Exception(e);
    }



  }
  

}