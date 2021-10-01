import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_task/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<ProductModel> cartItems = [];

  CartCubit() : super(CartInitial());

  void addProductToCart(ProductModel product) {
    emit(CartLoading());
    cartItems.add(product);
    // the fold() method iterates throught the CartItem list and adds the multiple of the item price and the item quantity.
    final total = cartItems.fold(
        0,
        (previousValue, element) =>
            double.parse(previousValue!.toString()) +
            (element.price * element.quantity));

    emit(CartItem(cartItems, total.toDouble()));
  }

  void removeProductFromCart(ProductModel product) {
    emit(CartLoading());
    cartItems.remove(product);

    final total = cartItems.fold(
        0,
        (previousValue, element) =>
            double.parse(previousValue!.toString()) +
            (element.price * element.quantity));
    emit(CartItem(cartItems, total.toDouble()));
  }

  void editProductDetails(String productID, int packs) {
    try {
      emit(CartLoading());
      final int index =
          cartItems.indexWhere((element) => element.productId == productID);
      // changing the  quantity of items in the cart
      cartItems[index].quantity = packs;
      final total = cartItems.fold(
          0,
          (previousValue, element) =>
              double.parse(previousValue!.toString()) +
              (element.price * element.quantity));
      emit(CartItem(cartItems, total.toDouble()));
    } catch (e) {
      emit(CartError());
    }
  }
}
