import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_task/cubit/search/search_cubit.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/screens/details_screen.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

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