import 'package:flutter/material.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

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
