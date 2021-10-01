import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_task/models/product_model.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future searchProducts(String key) async {
    try {
      emit(SearchLoading());
      final List<Map<String, dynamic>> mapProducts = [
        {
          "productId": "PRO12345",
          "name": "Paracetamol",
          "seller": "Emzor Pharmaceuticals",
          "price": 350.00,
          "weight": 500.00,
          "image": "paracetamol",
          "quantity": 0
        },
        {
          "productId": "PRO12346",
          "name": "Aspirin",
          "seller": "Aspirin Pharmaceuticals",
          "price": 350.00,
          "weight": 500.00,
          "image": "aspirin",
          "quantity": 0
        },
        {
          "productId": "PRO12347",
          "name": "Doliprane",
          "seller": "Doliprane Pharmaceuticals",
          "price": 350.00,
          "weight": 500.00,
          "image": "doliprane",
          "quantity": 0
        },
        {
          "productId": "PRO12348",
          "name": "Ibuprofen",
          "seller": "Ibuprofen Pharmaceuticals",
          "price": 350.00,
          "weight": 500.00,
          "image": "ibuprofen",
          "quantity": 0
        },
        {
          "productId": "PRO12349",
          "name": "Panadol",
          "seller": "Panadol Pharmaceuticals",
          "price": 350.00,
          "weight": 500.00,
          "image": "panadol",
          "quantity": 0
        },
      ];
      final List<ProductModel> products =
          mapProducts.map((e) => ProductModel.fromMap(e)).toList();

      if (key.isEmpty) {
        emit(SearchResults(products));
      } else {
        final results = products
            .where((element) =>
                element.name.toLowerCase().contains(key.toLowerCase()))
            .toList();
        emit(SearchResults(results));
      }
    } catch (e) {
      emit(SearchError());
    }
  }
}
