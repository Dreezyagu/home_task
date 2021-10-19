import 'package:flutter/material.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';


// the categories individual card widget

class CategoriesCard extends StatelessWidget {
  final int index;

  const CategoriesCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ["Headache", "Supplements", "Infants"];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(.02)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              context.width(.025),
            ),
            child: Image.asset(
              "assets/images/${categories[index % 3]}.jpeg".toLowerCase(),
              fit: BoxFit.fill,
              height: context.height(.12),
            ),
          ),
          Container(
            height: context.height(.12),
            width: context.width(.4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                context.width(.025),
              ),
              color: blackColor.withOpacity(.5),
            ),
          ),
          Text(categories[index % 3],
              style: TextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: context.width(.045),
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}