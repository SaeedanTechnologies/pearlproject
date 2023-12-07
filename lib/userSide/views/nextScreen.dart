import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/controller/categoryController.dart';
import 'package:pearl/userSide/views/pealSelect.dart';
import 'package:pearl/widgets/customIconButton.dart';
import 'package:pearl/widgets/pearlCustomBtn.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectSize extends StatelessWidget {
  const SelectSize({super.key});

  // Use GetX for global state management
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectCategoryController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/flower.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: CustomeIconButton(
                        icon: Icons.arrow_back,
                        iconcolor: apppurplecolor,
                        iconsize: 30.sp,
                        onPressed: () {
                          Get.back();
                        })),
                       Spacer(),
                Text(
                  'Select Size',
                  style: GoogleFonts.philosopher(
                      fontSize: 25.sp,
                      color: blackColor,
                      fontWeight: FontWeight.bold),
                ),
                50.heightBox,
                controller.selectedCategory.value == "Necklace"
                    ? Image.asset(
                        'assets/images/necklace.png', // Replace with your image path
                        width: 300,
                        height: 300,
                      )
                    : controller.selectedCategory.value == "Bracelet"
                        ? Image.asset(
                            'assets/images/bracelet.jpg', // Replace with your image path
                            width: 300,
                            height: 300,
                          )
                        : controller.selectedCategory.value == "Ring"
                            ? Image.asset(
                                'assets/images/ring.jpg', // Replace with your image path
                                width: 300,
                                height: 300,
                              )
                            : Container(),
                const SizedBox(height: 20),
                Text(
                  'Please Select Size',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: purpleColor),
                ),
                // Image.asset(
                //   'assets/images/arrow-slider.png', // Replace with your image path
                //   width: 100,
                //   height: 100,
                // ),
                const SizedBox(height: 20),
                controller.selectedCategory.value == "Necklace"
                    ? Obx(
                        () => DropdownButton(
                            style: GoogleFonts.raleway(color: blackColor),
                            value: controller.necklaceValue.value,
                            onChanged: (String? newValue) {
                              controller.necklaceValue.value = newValue!;
                              controller.selectSize.value=newValue;
                            },
                            items: controller.necklace),
                      )
                    : controller.selectedCategory.value == "Bracelet"
                        ? Obx(
                            () => DropdownButton(
                                style: GoogleFonts.raleway(color: blackColor),
                                value: controller.braceletValue.value,
                                onChanged: (String? newValue) {
                                  controller.braceletValue.value = newValue!;
                                   controller.selectSize.value=newValue;
                                },
                                items: controller.bracelet),
                          )
                        : controller.selectedCategory.value == "Ring"
                            ? Obx(
                                () => DropdownButton(
                                    style:
                                        GoogleFonts.raleway(color: blackColor),
                                    value: controller.ringValue.value,
                                    onChanged: (String? newValue) {
                                      controller.ringValue.value = newValue!;
                                       controller.selectSize.value=newValue;
                                    },
                                    items: controller.ring),
                              )
                            : controller.selectedCategory.value == "BigJewls"
                                ? DropdownButton(
                                    style:
                                        GoogleFonts.raleway(color: blackColor),
                                    value: controller.bagJewelValue.value,
                                    onChanged: (String? newValue) {
                                      controller.ringValue.value = newValue!;
                                       controller.selectSize.value=newValue;
                                    },
                                    items: controller.bagJewels)
                                : controller.selectedCategory.value ==
                                        "Earrings"
                                    ? DropdownButton(
                                        style: GoogleFonts.raleway(
                                            color: blackColor),
                                        value: controller.earringValue.value,
                                        onChanged: (String? newValue) {
                                          controller.bagJewelValue.value =
                                              newValue!;
                                               controller.selectSize.value=newValue;
                                        },
                                        items: controller.earringss)
                                    : Container(),
                const SizedBox(height: 20),

                pearCustomButton(
                    "Select Pearls", () => Get.to(() => ImagePickerScreen())),
                  Spacer(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
