import 'dart:convert';

class ProductModel {
  final String productId;
  final String name;
  final String seller;
  final double price;
  final double weight;
  final String image;
  int quantity;

  ProductModel(
      {required this.productId,
      required this.name,
      required this.seller,
      required this.price,
      required this.weight,
      required this.image,
      required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'seller': seller,
      'price': price,
      'weight': weight,
      'image': image,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      name: map['name'],
      seller: map['seller'],
      price: map['price'],
      weight: map['weight'],
      image: map['image'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
