import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_task/cubit/cart/cart_cubit.dart';
import 'package:home_task/cubit/search/search_cubit.dart';
import 'package:home_task/models/product_model.dart';
import 'package:home_task/screens/carts_screen.dart';
import 'package:home_task/screens/details_screen.dart';
import 'package:home_task/utils/constants.dart';
import 'package:home_task/utils/extensions.dart';
import 'package:home_task/widgets/spaces.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController search = TextEditingController();
  int currentIndex = 2;
  final List<String> bottomNavBarTitle = ["Home", "Moments", "Chat", "Profile"];

// listener to search for products at every change to the search textfield.
  void searchListener() {
    BlocProvider.of<SearchCubit>(context).searchProducts(search.text);
  }

  @override
  void initState() {
    super.initState();
    search.addListener(searchListener);

    //performing a search with an empty string at the start to get all products.
    BlocProvider.of<SearchCubit>(context).searchProducts("");
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/home.png",
            color: currentIndex == 0 ? purple : blackColor,
            height: context.width(.05),
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/doctor.png",
            color: currentIndex == 1 ? purple : blackColor,
            height: context.width(.05),
          ),
          label: "Doctors"),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/pharmacy.png",
            color: currentIndex == 2 ? purple : blackColor,
            height: context.width(.05),
          ),
          label: "Pharamacy"),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/community.png",
            color: currentIndex == 3 ? purple : blackColor,
            height: context.width(.05),
          ),
          label: "Community"),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/profile.png",
            color: currentIndex == 4 ? purple : blackColor,
            height: context.width(.05),
          ),
          label: "Profile")
    ];
    final int count = BlocProvider.of<CartCubit>(context).cartItems.length;
    return Scaffold(
        //bottom navigator bar
        bottomNavigationBar: SizedBox(
          height: context.height(.1),
          child: BottomNavigationBar(
            items: navBarItem,
            elevation: 0,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            selectedItemColor: purple,
            unselectedItemColor: lightGrey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            currentIndex: currentIndex,
          ),
        ),
        body: Column(
          children: [
            Header(controller: search),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width(.01)),
                child: Container(
                  color: whiteColor,
                  padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(vertical: context.height(.02)),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("CATEGORIES",
                              style: TextStyle(
                                  color: lightGrey,
                                  fontSize: context.width(.04),
                                  fontWeight: FontWeight.w600)),
                          Text("VIEW ALL",
                              style: TextStyle(
                                  color: purple,
                                  fontSize: context.width(.035),
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Hspace(context.height(.01)),
                      SizedBox(
                        height: context.height(.13),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              CategoriesCard(index: index),
                        ),
                      ),
                      Hspace(context.height(.03)),
                      Text("SUGGESTIONS",
                          style: TextStyle(
                              color: lightGrey,
                              fontSize: context.width(.04),
                              fontWeight: FontWeight.w600)),
                      Hspace(context.height(.02)),
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return const CupertinoActivityIndicator();
                          } else if (state is SearchResults) {
                            final products = state.products;
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: context.width(.05),
                                      mainAxisSpacing: context.height(.02),
                                      childAspectRatio: .7,
                                      crossAxisCount: 2),
                              itemCount: products.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () async {
                                    search.clear();
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Details(product: products[index]),
                                        ));
                                    if (result == true) {
                                      setState(() {});
                                    }
                                  },
                                  child:
                                      SuggestedCard(product: products[index])),
                            );
                          }
                          return Container();
                        },
                      ),
                      Hspace(context.height(.1)),
                      checkoutButton(context, count)
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

// the checkout button at the bottom of the listview.
  Align checkoutButton(BuildContext context, int count) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
          onTap: () async {
            search.clear();
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartsScreen(),
                ));
            if (result == true) {
              setState(() {});
            }
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(context.width(.075))),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: context.height(.07),
                  width: context.width(.52),
                  padding: EdgeInsets.symmetric(
                      horizontal: context.width(.06),
                      vertical: context.height(.025)),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffFE806F),
                        spreadRadius: 1,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(context.width(.075))),
                  ),
                ),
                Container(
                  width: context.width(.5),
                  height: context.height(.06),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width(.06),
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xffFE806F), Color(0xffE5366A)]),
                    borderRadius:
                        BorderRadius.all(Radius.circular(context.width(.075))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Checkout  ",
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: context.width(.04))),
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: whiteColor,
                      ),
                      Container(
                          height: context.width(.05),
                          width: context.width(.05),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffF1CA4B)),
                          child: Center(
                            child: Text("$count",
                                style: TextStyle(
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.width(.03))),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

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

// header widget: including the search textfield
class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xffF2F2F2),
          height: context.height(.25),
        ),
        Column(
          children: [
            Container(
              height: context.height(.2),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: context.width(.06),
                  vertical: context.height(.025)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff7A08FA), Color(0xffAD3BFC)]),
                borderRadius:
                    BorderRadius.all(Radius.circular(context.width(.075))),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pharmacy",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: context.width(.045),
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.favorite_border_outlined,
                              color: whiteColor),
                          Wspace(context.width(.02)),
                          Image.asset(
                            "assets/icons/delivery.png",
                            color: whiteColor,
                          )
                        ],
                      )
                    ],
                  ),
                  Hspace(context.height(.025)),
                  TextField(
                    controller: controller,
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: context.width(.045),
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: whiteColor,
                        ),
                        filled: true,
                        fillColor: whiteColor.withOpacity(.3),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.circular(context.width(.03))),
                        contentPadding: EdgeInsets.all(context.width(.01)),
                        hintStyle: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.w400),
                        hintText: "Search"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: context.height(.05),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width(.08)),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: blackColor,
                                fontSize: context.width(.04),
                                fontWeight: FontWeight.w400),
                            children: const [
                          TextSpan(text: " Delivery in "),
                          TextSpan(
                            text: "Lagos, NG",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
