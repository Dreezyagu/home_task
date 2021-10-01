import 'package:bloc/bloc.dart';
import 'package:home_task/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<ProductModel> cartItems = [];

  CartCubit() : super(CartInitial());

  void addProductToCart(ProductModel product) {
    emit(CartLoading());
    cartItems.add(product);
    double total = 0;

    for (var i = 0; i < cartItems.length; i++) {
      total = total + cartItems[i].price * cartItems[i].quantity;
    }
    emit(CartItem(cartItems, total));
  }

  void removeProductFromCart(ProductModel product) {
    emit(CartLoading());
    cartItems.remove(product);
    double total = 0;

    for (var i = 0; i < cartItems.length; i++) {
      total = total + cartItems[i].price * cartItems[i].quantity;
    }
    emit(CartItem(cartItems, total));
  }

  void editProductDetails(String productID, int packs) {
    emit(CartLoading());
    final int index =
        cartItems.indexWhere((element) => element.productId == productID);
    cartItems[index].quantity = packs;
    double total = 0;

    for (var i = 0; i < cartItems.length; i++) {
      total = total + cartItems[i].price * cartItems[i].quantity;
    }
    emit(CartItem(cartItems, total));
  }
}
