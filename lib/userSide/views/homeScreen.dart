import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/userSide/controller/categoryController.dart';
import 'package:pearl/userSide/views/categoryScreen.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/widgets/customIconButton.dart';
import 'package:pearl/widgets/pearlCustomBtn.dart';
import 'package:pearl/widgets/radiobutton.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectCategoryController());
    return Scaffold(
      // actions: [
      //   ElevatedButton(
      //     onPressed: () async {
      //       await _firebaseAuth
      //           .signOut()
      //           .then((value) => Get.to(() => LoginScreen()));
      //       //          userController.sendNotificationToPlayer("6fbbc31d-fb5d-4d8f-bc0b-5fd4aeb2d9b8", "Your notification message");
      //       //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
      //     },
      //     child: const Text('Logout'),
      //   ),

      // Text(_firebaseAuth.currentUser!.uid)
      //   ElevatedButton(
      //     onPressed: () async {
      //       Get.to(() => CatalogScreen());
      //       //          userController.sendNotificationToPlayer("6fbbc31d-fb5d-4d8f-bc0b-5fd4aeb2d9b8", "Your notification message");
      //       //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
      //     },
      //     child: const Text('Marketplace'),
      //   ),
      // ],

      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/flower.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Gender',
                  style: GoogleFonts.philosopher(
                      fontSize: 25.sp,
                      color: blackColor,
                      fontWeight: FontWeight.bold),
                ),

                50.heightBox,
                customRadioButton(controller.selectedGender, "Male"),
                customRadioButton(controller.selectedGender, "Female"),
                40.heightBox,
                // ElevatedButton(
                //   onPressed: () {
                // //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
                //   },
                //   child: Text('Continue'),
                // ),

                pearCustomButton("Select Category", () {
                  Get.to(() => const CategoryScreen());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
