import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  Orientation orientation() => MediaQuery.of(this).orientation;
  double height([double percent = 1]) {
    return orientation() == Orientation.portrait
        ? MediaQuery.of(this).size.height * percent
        : MediaQuery.of(this).size.width * percent;
  }

  double width([double percent = 1]) {
    {
      return orientation() == Orientation.landscape
          ? MediaQuery.of(this).size.height * percent
          : MediaQuery.of(this).size.width * percent;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get inLows =>
      length > 0 ? '${this[0].toLowerCase()}${substring(1)}' : '';
  String get lowercaseFirsts => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inLows)
      .join(" ");
  String get commalise => replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}
