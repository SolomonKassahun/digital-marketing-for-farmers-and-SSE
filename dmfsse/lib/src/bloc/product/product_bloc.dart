import 'package:dmfsse/src/bloc/product/product_event.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/data_repository/product_data_repository.dart';
import 'package:dmfsse/src/models/product.dart';
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
            emit(AddProductLoading());
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
          print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
          if (productDetail != []) {
            print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
            emit(FetchAllProductSucess(product: productDetail));
          } else {
            print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
            emit(FetchAllProductFailure(message: "No connection"));
          }
        } catch (e) {
          throw Exception("z e iiss $e");
        }
      }
    });
  }
}
