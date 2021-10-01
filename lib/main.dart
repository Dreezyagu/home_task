import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_task/cubit/cart/cart_cubit.dart';
import 'package:home_task/cubit/search/search_cubit.dart';
import 'package:home_task/screens/homepage.dart';

void main() {
  runApp(
      //Wrapping the entire app with the BlocProviders used in the app.
      MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SearchCubit(),
      ),
      BlocProvider(
        create: (context) => CartCubit(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: const Color(0xffE5E5E5),
          fontFamily: "ProximaNova"),
      home: const Homepage(),
    );
  }
}
