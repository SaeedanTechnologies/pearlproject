import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.textcolor,
  });
  final Callback onPressed;
  final String buttonName;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: TextStyle(color: textcolor,fontSize: 17.sp,),
      ),
    );
  }
}
