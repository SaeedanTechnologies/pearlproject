import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';

Widget customRadioButton(RxString? value, String btnName) {
  return SizedBox(
    width: 130.w,
    child: Row(
      children: [
        Obx(
          () => Radio(
              value: btnName,
              groupValue: value!.value,
              onChanged: (hm) {
                value.value = hm!;
              }),
        ),
        Text(
          btnName,
          style: GoogleFonts.raleway(fontSize: 15.sp, color: blackColor),
        ),
      ],
    ),
  );
}
