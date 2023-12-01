import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pearl/userSide/controller/userController.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    userController.getPoints();
    userController.getOffers();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ],
                ),
                20.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 50.r,
                          backgroundImage:
                              const AssetImage("assets/images/ring.jpg")),
                      20.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Abdul Salam"
                              .toString()
                              .text
                              .black
                              .size(20.sp)
                              .bold
                              .make(),
                          10.heightBox,
                          FirebaseAuth.instance.currentUser!.email
                              .toString()
                              .text
                              .black
                              .size(15.sp)
                              .bold
                              .make()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
                .box
                .height(200.h)
                .white
                .outerShadow
                .width(double.infinity)
                .bottomRounded()
                .make(),
            10.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                "Point & Rewards".text.bold.black.size(18.sp).make(),
                30.heightBox,
                Row(
                  children: [
                    "Total Points:".text.black.bold.size(14.sp).make(),
                    Obx(
                      () => userController.points.value.text
                          .size(14.sp)
                          .black
                          .make(),
                    )
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    "Offers:".text.black.bold.size(14.sp).make(),
                    userController.offers.value
                        .toString()
                        .text
                        .size(14.sp)
                        .black
                        .make()
                  ],
                ),
                10.heightBox,
              ],
            )
                .box
                .rounded
                .padding(const EdgeInsets.all(8))
                .white
                .outerShadow
                .make(),
            10.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                "Personal Information".text.bold.black.size(18.sp).make(),
                30.heightBox,
                Row(
                  children: [
                    "Full Name: ".text.black.bold.size(14.sp).make(),
                    "John Divid".text.size(14.sp).black.make()
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    "Gender:".text.black.bold.size(14.sp).make(),
                    "Male".text.size(14.sp).black.make()
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    "Contact:".text.black.bold.size(14.sp).make(),
                    "031100000000".text.size(14.sp).black.make()
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    "Address:".text.black.bold.size(14.sp).make(),
                    "Gulber III, Lahore, Punjab, Pakistan"
                        .text
                        .size(14.sp)
                        .black
                        .make()
                  ],
                ),
                10.heightBox,
              ],
            )
                .box
                .rounded
                .padding(const EdgeInsets.all(8))
                .white
                .outerShadow
                .make()
          ],
        ),
      ),
    );
  }
}
