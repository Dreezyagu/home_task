part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartItem extends CartState {
  final List<ProductModel> products;
  final double total;

  CartItem(this.products, this.total);
}
