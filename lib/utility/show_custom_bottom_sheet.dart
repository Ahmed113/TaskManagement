import 'package:flutter/material.dart';

void showCustomBottomSheet(
    {required BuildContext context,
    required Widget child,
    bool isScrollable = false,
    BoxConstraints? constraints}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollable,
    useSafeArea: true,
    constraints: constraints,
    builder: (BuildContext context) {
      return child;
    },
  );
}
