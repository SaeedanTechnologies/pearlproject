import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pearl/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customeTextField(
    {required String hinttext,
    required TextEditingController controller,
    bool obsecure = false, required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      style: const TextStyle(color: blackColor),
      obscureText: obsecure,
    
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 5,left: 15),
          prefixIcon: Icon(icon),
        hintText: hinttext,
        border: const OutlineInputBorder(),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(40.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40.r)),
      ),
      controller: controller,
    ).box.height(40.h).make(),
  );
}
