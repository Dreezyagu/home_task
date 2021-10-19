import 'package:flutter/material.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

// the suggestions individual card widget

class SuggestedCard extends StatelessWidget {
  const SuggestedCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Material(
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
              height: context.height(.165),
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
            Expanded(
              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}