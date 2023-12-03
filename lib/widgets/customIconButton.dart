import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomeIconButton extends StatelessWidget {
  const CustomeIconButton(
      {super.key,
      required this.icon,
      required this.iconcolor,
      required this.iconsize,
      required this.onPressed});
  final Callback onPressed;
  final IconData icon;
  final Color iconcolor;
  final double iconsize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconcolor,
          size: iconsize,
        ));
  }
}
