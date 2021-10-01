import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_task/cubit/cart/cart_cubit.dart';
import 'package:home_task/cubit/search/search_cubit.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/screens/carts_screen.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

class Details extends StatefulWidget {
  final ProductModel product;
  const Details({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int packs = 1;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final products = BlocProvider.of<CartCubit>(context).cartItems;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width(.005)),
            child: Stack(
              children: [
                Container(
                  height: context.height(),
                  width: double.infinity,
                  color: whiteColor,
                ),
                Column(
                  children: [
                    const Header(),
                    Container(
                      height: context.height(.85),
                      color: whiteColor,
                      child: ListView(
                        children: [
                          Intro(product: product),
                          packsNo(product),
                          ProductDetails(product: product),
                          const SimilarProducts(),
                          Visibility(
                            visible: !products.any((element) =>
                                element.productId == product.productId),
                            child: InkWell(
                                onTap: () {
                                  product.quantity = packs;
                                  BlocProvider.of<CartCubit>(context)
                                      .addProductToCart(product);

                                  dialog(context, product).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: const Button()),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialog(BuildContext context, ProductModel product) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hspace(context.height(.02)),
                    Text(
                      "${product.name} has been successfully added to cart!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: context.width(.038)),
                    ),
                    Hspace(context.height(.05)),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartsScreen(),
                            ));
                      },
                      child: Container(
                          // height: context.height(.14),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width(.04),
                              vertical: context.height(.0175)),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xff7A08FA), Color(0xffAD3BFC)]),
                            borderRadius: BorderRadius.all(
                                Radius.circular(context.width(.035))),
                          ),
                          child: Center(
                            child: Text("VIEW CART",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.width(.035))),
                          )),
                    ),
                    Hspace(context.height(.02)),
                    InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                          // height: context.height(.14),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: context.height(.0175)),
                          decoration: BoxDecoration(
                            border: Border.all(color: purple, width: 2),
                            borderRadius: BorderRadius.all(
                                Radius.circular(context.width(.035))),
                          ),
                          child: Center(
                            child: Text("CONTINUE SHOPPING",
                                style: TextStyle(
                                    color: purple,
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.width(.035))),
                          )),
                    )
                  ],
                ),
              )),
    );
  }

// function to select number of packs
  Padding packsNo(ProductModel product) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(.08)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: context.width(.1),
                    width: context.width(.1),
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: lightGrey, width: .5)),
                    child: Image.asset(
                      "assets/images/emzor.jpeg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Wspace(context.width(.03)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SOLD BY",
                        style: TextStyle(
                            color: const Color(0xff8EA5BC),
                            fontSize: context.width(.03),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Emzor Pharmaceuticals",
                        style: TextStyle(
                            color: middleBlue,
                            fontSize: context.width(.04),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: context.width(.1),
                width: context.width(.1),
                decoration: BoxDecoration(
                    color: const Color(0xffF5EEFC),
                    borderRadius: BorderRadius.circular(context.width(.02))),
                child: const Icon(
                  Icons.favorite_border,
                  color: purple,
                ),
              )
            ],
          ),
          Hspace(context.height(.03)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.width(.05)),
                        border: Border.all(color: lightMediumGrey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: packs <= 1
                                ? null
                                : () {
                                    setState(() {
                                      packs--;
                                    });
                                  },
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: darkGrey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.width(.05)),
                            )),
                        Text(
                          "$packs",
                          style: TextStyle(
                              color: darkGrey,
                              fontWeight: FontWeight.w700,
                              fontSize: context.width(.045)),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                packs++;
                              });
                            },
                            child: Text(
                              "+",
                              style: TextStyle(
                                  color: darkGrey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.width(.05)),
                            )),
                      ],
                    ),
                  ),
                  Text(
                    "   Pack(s)",
                    style: TextStyle(
                        color: lightGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: context.width(.035)),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "₦",
                      style: TextStyle(
                          color: darkGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: context.width(.04)),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${product.price.round() * packs}",
                        style: TextStyle(
                            height: 1,
                            color: darkGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: context.width(.06)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          ".00",
                          style: TextStyle(
                              color: darkGrey,
                              fontWeight: FontWeight.w700,
                              fontSize: context.width(.04)),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(.06)),
      child: Container(
          // height: context.height(.14),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.04), vertical: context.height(.02)),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xff7A08FA), Color(0xffAD3BFC)]),
            borderRadius:
                BorderRadius.all(Radius.circular(context.width(.035))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                color: whiteColor,
              ),
              Text("    Add to Cart",
                  style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: context.width(.04))),
            ],
          )),
    );
  }
}

// the similar products custom widget
class SimilarProducts extends StatelessWidget {
  const SimilarProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hspace(context.height(.05)),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("     Similar Products",
              style: TextStyle(
                  color: darkGrey,
                  fontSize: context.width(.05),
                  fontWeight: FontWeight.w700)),
        ),
        Hspace(context.height(.025)),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const CupertinoActivityIndicator();
            } else if (state is SearchResults) {
              final products = state.products;
              return SizedBox(
                height: context.height(.25),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Details(product: products[index]),
                            ));
                      },
                      child: SimilarProductCard(product: products[index])),
                ),
              );
            }
            return Container();
          },
        ),
        Hspace(context.height(.04)),
      ],
    );
  }
}

// the similar product individual card widget
class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
      child: Material(
        elevation: 0.5,
        child: Container(
          height: context.height(.15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.width(.025)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: context.height(.12),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.width(.025)),
                    topRight: Radius.circular(context.width(.025)),
                  ),
                  child: Image.asset(
                    "assets/images/${product.image}.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.height(.015),
                    horizontal: context.width(.04)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: context.width(.04),
                            fontWeight: FontWeight.w600)),
                    Hspace(context.height(.005)),
                    Row(
                      children: [
                        Text("Tablet • ${product.weight.round()}mg",
                            style: TextStyle(
                                color: lightGrey,
                                fontSize: context.width(.035),
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Hspace(context.height(.01)),
                    Text("₦${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: darkGrey,
                            fontSize: context.width(.04),
                            fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// custom widget for the product details, including the header.
class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(.08)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hspace(context.height(.05)),
          Text(
            "PRODUCT DETAILS",
            style: TextStyle(
                color: const Color(0xff8EA5BC),
                fontSize: context.width(.04),
                fontWeight: FontWeight.w700),
          ),
          Hspace(context.height(.015)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ProductDetail(
                icon: "pack",
                title: "PACK SIZE",
                value: "8 x 12 tablets (96)",
              ),
              ProductDetail(
                icon: "product_id",
                title: "PRODUCT ID",
                value: product.productId,
              ),
            ],
          ),
          Hspace(context.height(.02)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductDetail(
                icon: "constituents",
                title: "CONSTITUENTS",
                value: product.name,
              ),
              const ProductDetail(
                icon: "dispense",
                title: "DISPENSED IN",
                value: "Packs",
              ),
            ],
          ),
          Hspace(context.height(.05)),
          Text(
            "1 pack of ${product.name} (${product.weight.round()}mg) contains 8 units of 12 tablets.",
            style: TextStyle(
                color: darkGrey.withOpacity(.6),
                fontSize: context.width(.04),
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

// custom widget for the individual product details.
class ProductDetail extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const ProductDetail(
      {Key? key, required this.icon, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/icons/$icon.png",
          color: purple,
          height: context.width(.075),
        ),
        Wspace(context.width(.03)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: const Color(0xff8EA5BC),
                  fontSize: context.width(.03),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              value,
              style: TextStyle(
                  color: middleBlue,
                  fontSize: context.width(.035),
                  fontWeight: FontWeight.w700),
            ),
          ],
        )
      ],
    );
  }
}

// custom widget containing the product image, name and weight.
class Intro extends StatelessWidget {
  const Intro({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.width(.05)),
          child: Image.asset(
            "assets/images/${product.image}.jpeg",
            height: context.height(.15),
          ),
        ),
        Hspace(context.height(.03)),
        Text(
          product.name,
          style: TextStyle(
              color: darkGrey,
              fontSize: context.width(.05),
              fontWeight: FontWeight.w600),
        ),
        Hspace(context.height(.01)),
        Text("Tablet - ${product.weight.round()}mg",
            style: TextStyle(
                color: lightGrey,
                fontSize: context.width(.04),
                fontWeight: FontWeight.w400)),
        Hspace(context.height(.05)),
      ],
    );
  }
}

// header widget
class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height(.14),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.width(.04),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xff7A08FA), Color(0xffAD3BFC)]),
        borderRadius: BorderRadius.all(Radius.circular(context.width(.075))),
      ),
      child: Column(
        children: [
          SizedBox(height: context.height(.06)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context, true),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: lightGrey,
                      )),
                  Text(
                    "Pharmacy",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: context.width(.045),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartsScreen(),
                      )),
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: whiteColor))
            ],
          ),
        ],
      ),
    );
  }
}
