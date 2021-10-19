import 'package:flutter/material.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

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