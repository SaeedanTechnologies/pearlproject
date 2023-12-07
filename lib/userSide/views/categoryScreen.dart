import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/controller/categoryController.dart';
import 'package:pearl/userSide/views/nextScreen.dart';
import 'package:pearl/widgets/customIconButton.dart';
import 'package:pearl/widgets/pearlCustomBtn.dart';
import 'package:pearl/widgets/radiobutton.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectCategoryController());
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text('Category Screen'),
        //   actions: [
        //     ElevatedButton(
        //       onPressed: () async {
        //         await _firebaseAuth
        //             .signOut()
        //             .then((value) => Get.to(() => LoginScreen()));

        //         //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
        //       },
        //       child: const Text('Logout'),
        //     ),
        //   ],
        // ),
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/flower.jpg"),
                fit: BoxFit.cover)),
        child: Center(
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
                'Select Category',
                style: GoogleFonts.philosopher(
                    fontSize: 25.sp,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
              100.heightBox,

              customRadioButton(controller.selectedCategory, "Necklace"),
              customRadioButton(controller.selectedCategory, "Bracelet"),
              customRadioButton(controller.selectedCategory, "Ring"),
              customRadioButton(controller.selectedCategory, "BigJewls"),
              customRadioButton(controller.selectedCategory, "Earrings"),

              40.heightBox,
              // ElevatedButton(
              //   onPressed: () {
              // //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
              //   },
              //   child: Text('Continue'),
              // ),

              pearCustomButton("Select Category", () {
                Get.to(() =>  SelectSize());
              }),
             Spacer(),
            ],
          ),
        ),
      ),
    ));
  }
}
