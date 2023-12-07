import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget targetPearlWidget(
    {double? left,
    double? top ,
    double? right ,
    double? bottom ,
    required RxString image,
    required double pearlwidth,
    required double pearlheight}) {
  return Positioned(
    left: left?.w,
    top: top?.h,
    right: right?.w,
    bottom: bottom?.h,
    child: Stack(
      children: [
        DragTarget<String>(
            onAccept: (String data) async {
              image.value = data;
            },
            builder: (context, candidateData, rejectedData) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  width: pearlwidth,
                  height: pearlheight,
                  child: Obx(
                    () => image.value == ""
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () async {
                              image.value = "";
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                image.value,
                              ),
                            ),
                          ),
                  ),
                )),
      ],
    ),
  );
}
