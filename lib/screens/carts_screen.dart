import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_task/cubit/cart/cart_cubit.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  _CartsScreenState createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  List<int> quantityList = [];

  @override
  Widget build(BuildContext context) {
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
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          if (state is CartItem) {
                            final cartItems = state.products;

                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: cartItems.length,
                                    itemBuilder: (context, index) {
                                      for (var i = 0;
                                          i < cartItems.length;
                                          i++) {
                                        quantityList.add(cartItems[i].quantity);
                                      }

                                      return cartItemCard(
                                          context, cartItems, index);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.width(.04)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "Total: ₦${state.total.toStringAsFixed(2)}"
                                                .commalise,
                                            style: TextStyle(
                                                color: darkGrey,
                                                fontWeight: FontWeight.w800,
                                                fontSize: context.width(.045))),
                                      ),
                                      Container(
                                          // height: context.height(.14),
                                          width: context.width(.5),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: context.width(.04),
                                              vertical: context.height(.02)),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xff7A08FA),
                                                  Color(0xffAD3BFC)
                                                ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    context.width(.035))),
                                          ),
                                          child: Center(
                                            child: Text("CHECKOUT",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        context.width(.04))),
                                          )),
                                    ],
                                  ),
                                ),
                                Hspace(context.height(.03))
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding cartItemCard(
      BuildContext context, List<ProductModel> cartItems, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
      child: Column(
        children: [
          SizedBox(
            height: context.height(.075),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.width(.05)),
                      child: Image.asset(
                        "assets/images/${cartItems[index].image}.jpeg",
                        height: context.height(.07),
                      ),
                    ),
                    Wspace(context.width(.04)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItems[index].name,
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: context.width(.04),
                                fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            Text(
                                "Tablet • ${cartItems[index].weight.round()}mg",
                                style: TextStyle(
                                    color: lightGrey,
                                    fontSize: context.width(.035),
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Text(
                            "₦${(cartItems[index].price * cartItems[index].quantity).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: darkGrey,
                                fontSize: context.width(.04),
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: context.width(.2),
                      height: context.height(.04),
                      padding: EdgeInsets.only(
                        left: context.width(.04),
                        right: context.width(.015),
                      ),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: lightGrey),
                          borderRadius:
                              BorderRadius.circular(context.width(.025))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          iconEnabledColor: purple,
                          value: quantityList[index],
                          style: TextStyle(
                              color: darkGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: context.width(.03)),
                          onChanged: (int? a) {
                            setState(() {
                              quantityList[index] = a!;
                              BlocProvider.of<CartCubit>(context)
                                  .editProductDetails(
                                      cartItems[index].productId, a);
                            });
                          },
                          items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                              .map<DropdownMenuItem<int>>((value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                "$value",
                                style: TextStyle(
                                    color: darkGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.width(.04)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => BlocProvider.of<CartCubit>(context)
                          .removeProductFromCart(cartItems[index]),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_outline,
                            color: purple,
                          ),
                          Text(" Remove",
                              style: TextStyle(
                                  color: purple,
                                  fontSize: context.width(.035),
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: context.height(.05),
            child: const Divider(),
          )
        ],
      ),
    );
  }
}

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
            bottomLeft: Radius.circular(context.width(.075)),
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
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: whiteColor,
                  ),
                  Text(
                    "  Carts",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: context.width(.045),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Icon(Icons.favorite_border, color: whiteColor)
            ],
          ),
        ],
      ),
    );
  }
}
