part of 'cart_cubit.dart';

@immutable
abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {}

class CartItem extends CartState {
  final List<ProductModel> products;
  final double total;

  CartItem(this.products, this.total);
}
