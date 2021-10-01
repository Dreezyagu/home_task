import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_task/cubit/cart/cart_cubit.dart';
import 'package:home_task/cubit/search/search_cubit.dart';
import 'package:home_task/models/product_model.dart';

void main() {
  group("Unit tests", () {
    SearchCubit? searchCubit;
    CartCubit? cartCubit;
    final paracetamolProduct = ProductModel.fromMap(
      // ignore: prefer_const_literals_to_create_immutables
      {
        "productId": "PRO12345",
        "name": "Paracetamol",
        "seller": "Emzor Pharmaceuticals",
        "price": 350.00,
        "weight": 500.00,
        "image": "paracetamol",
        "quantity": 0
      },
    );
    setUp(() {
      EquatableConfig.stringify = true;
      searchCubit = SearchCubit();
      cartCubit = CartCubit();
    });

    blocTest<SearchCubit, SearchState>("Search test",
        build: () => searchCubit!,
        act: (cubit) => cubit.searchProducts("Paracetamol"),
        expect: () => [
              SearchLoading(),
              SearchResults([paracetamolProduct])
            ]);

    blocTest<CartCubit, CartState>("Add Carts Test",
        build: () => cartCubit!,
        act: (cubit) => cubit.addProductToCart(paracetamolProduct),
        expect: () => [
              CartLoading(),
              CartItem([paracetamolProduct], 1)
            ]);
    blocTest<CartCubit, CartState>("Remove Carts Test",
        build: () => cartCubit!,
        act: (cubit) => cubit.removeProductFromCart(paracetamolProduct),
        expect: () => [CartLoading(), CartItem(const [], 0)]);

    tearDown(() {
      searchCubit?.close();
    });
  });
}
