import 'package:flutter/material.dart';

class TrolleyHeader extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  const TrolleyHeader({Key? key, this.title, this.titleStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "MY CART",
      style: titleStyle ?? const TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
