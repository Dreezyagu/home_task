import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_task/cubit/cart/cart_cubit.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/screens/carts_screen.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/details_intro.dart';
import 'package:home_task/widgets/product_details.dart';
import 'package:home_task/widgets/similar_products.dart';
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
    return Scaffold(
      body: Column(
        children: [
          Stack(
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
                        Hspace(context.height(.1))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartItem) {
            final products = state.products;
            return Visibility(
              visible: !products
                  .any((element) => element.productId == product.productId),
              child: InkWell(
                  onTap: () {
                    product.quantity = packs;
                    BlocProvider.of<CartCubit>(context)
                        .addProductToCart(product);

                    dialog(context, product).then((value) {
                      setState(() {});
                    });
                  },
                  child: addToCartButton()),
            );
          } else {
            return InkWell(
                onTap: () {
                  product.quantity = packs;
                  BlocProvider.of<CartCubit>(context).addProductToCart(product);

                  dialog(context, product).then((value) {
                    setState(() {});
                  });
                },
                child: addToCartButton());
          }
        },
      ),
    );
  }

// widget functions that pops up on a successful addition to cart
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
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width(.04),
                              vertical: context.height(.0185)),
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

// widget function button to add product item to cart.
  Widget addToCartButton() {
    return Padding(
      padding: EdgeInsets.only(left: context.width(.08)),
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
                                  fontSize: context.width(.045)),
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
                                  fontSize: context.width(.045)),
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
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              context.width(.075),
            ),
            bottomRight: Radius.circular(context.width(.075))),
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
