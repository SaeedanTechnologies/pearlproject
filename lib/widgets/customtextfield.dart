import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customeTextField(
    {required String hinttext,
    required TextEditingController controller,
    bool obsecure = false,
    bool readonly=false,
    required IconData icon}) {
  return TextField(
    style: const TextStyle(color: blackColor),
    obscureText: obsecure,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.only(left: 15),
      prefixIcon: Icon(
        icon,
        color: apppurplecolor,
      ),
      
      hintText: hinttext,
      hintStyle: GoogleFonts.raleway(color: blackColor),
      border: const OutlineInputBorder(),
      fillColor: Colors.white.withOpacity(0.7),
      filled: true,
      // enabledBorder:
      //     OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
    controller: controller,
  ).box.withRounded(value: 10).clip(Clip.antiAlias).height(35.h).make();
}
