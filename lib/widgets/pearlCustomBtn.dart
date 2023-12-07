import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget pearCustomButton(String btnName, Function onpress) {
  return GestureDetector(
    onTap: () {
      onpress();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          btnName,
          style: GoogleFonts.raleway(fontSize: 15.sp, color: blackColor),
        ),
        10.widthBox,
        Image.asset("assets/btn.png"),
      ],
    ),
  );
}
