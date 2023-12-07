import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/views/homeScreen.dart';
import 'package:pearl/userSide/views/loginScreen.dart';
import 'package:pearl/userSide/views/marketplace.dart';
import 'package:pearl/widgets/customIconButton.dart';
import 'package:pearl/widgets/pearlCustomBtn.dart';
import 'package:velocity_x/velocity_x.dart';

class TheConcept extends StatelessWidget {
  const TheConcept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        10.heightBox,
                        Center(
                          child: Row(
                            children: [
                              CustomeIconButton(
                                  icon: Icons.arrow_back_ios,
                                  iconcolor: whiteColor,
                                  iconsize: 20.sp,
                                  onPressed: () {
                                    Get.back();
                                  }),
                              Text(
                                "THE MAGICSTONE CONCEPT",
                                style: GoogleFonts.philosopher(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,
                        Image.asset("assets/images/stones.png"),
                        30.heightBox,
                        Text(
                          "Introducing the MagicStone Perlerie mobile experience – where your jewelry becomes an expression of you! Choose from a range of personalized options:",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp, color: whiteColor),
                        ),
                        20.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ring",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                              Text(
                                "Earrings",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                              Text(
                                "Bracelet",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Big Jewels",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                              Text(
                                "Necklace",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                              Text(
                                "Key Ring",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Brooch",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                              70.widthBox,
                              Text(
                                "Pendant",
                                style: GoogleFonts.raleway(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,
                        Image.asset("assets/whitebtn.png")
                            .box
                            .color(whiteColor.withOpacity(0.3))
                            .padding(const EdgeInsets.all(12))
                            .roundedSM
                            .make(),
                      ],
                    ),
                  ),
                ],
              ).box.color(const Color(0xff852B5E)).make(),
              Container(
                width: double.infinity,
                height: 500.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bgimg.png"))),
                child: Column(
                  children: [
                    20.heightBox,
                    Text(
                      "We offer your better quality products",
                      style: GoogleFonts.niconne(
                          fontSize: 20.sp,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: blackColor),
                    ),
                    50.heightBox,
                    Image.asset("assets/images/img2.png"),
                    50.heightBox,
                    Image.asset("assets/images/pinkbutton.png")
                        .box
                        .color(const Color(0xffE2CCD8))
                        .roundedSM
                        .width(180.w)
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(() => CatalogScreen());
                    }),
                    20.heightBox,
                    Image.asset("assets/images/customorder.png")
                        .box
                        .color(const Color(0xffE2CCD8))
                        .roundedSM
                        .width(180.w)
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                          Get.to(() => LoginScreen());
                      // if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
                      //   Get.to(() => HomeScreen());
                      // } else {
                      //   Get.to(() => LoginScreen());
                      // }
                    }),
                    20.heightBox,
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "What  do we put in our products",
                            style: GoogleFonts.niconne(
                                color: const Color(0xff852B5E),
                                fontSize: 22.sp),
                          ),
                        ),
                        20.heightBox,
                        Center(child: Image.asset("assets/images/img3.png")),
                        30.heightBox,
                        Text(
                          "Know-how",
                          style: GoogleFonts.philosopher(
                              fontSize: 20.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        5.heightBox,
                        Text(
                          "We have been creators and manufacturers for 16 years.",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp, color: blackColor),
                          textAlign: TextAlign.justify,
                        ),
                        20.heightBox,
                        Text(
                          "Made in France",
                          style: GoogleFonts.philosopher(
                              fontSize: 20.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        5.heightBox,
                        Text(
                          "All our products are created in our workshops in France.",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp, color: blackColor),
                          textAlign: TextAlign.justify,
                        ),
                        20.heightBox,
                        Text(
                          "Quality",
                          style: GoogleFonts.philosopher(
                              fontSize: 20.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        5.heightBox,
                        Text(
                          "Our working method respects strict commitments.included in our quality charter.",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp, color: blackColor),
                          textAlign: TextAlign.justify,
                        ),
                        20.heightBox,
                        Text(
                          "Passion",
                          style: GoogleFonts.philosopher(
                              fontSize: 20.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        5.heightBox,
                        Text(
                          "We are committed to offering you the best of our profession.",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp, color: blackColor),
                          textAlign: TextAlign.justify,
                        ),
                        20.heightBox,
                        Text(
                          "Creativity",
                          style: GoogleFonts.philosopher(
                              fontSize: 20.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        5.heightBox,
                        Text(
                          "Our collections are modern with pretty combinations of materials and beautiful colors..",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp, color: blackColor),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  )
                ],
              )
                  .box
                  .color(const Color(0xffECECEE))
                  .width(double.infinity)
                  .make(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Exclusive offers, new collections, and VIP perks await",
                          style: GoogleFonts.philosopher(
                              color: blackColor, fontSize: 13.sp),
                        ),
                        20.heightBox,
                        Container(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff852C5D)),
                                child: Text(
                                  "I'm Registering",
                                  style: GoogleFonts.philosopher(
                                      color: whiteColor),
                                ),
                              ),
                            ),
                          ),
                        )
                            .box
                            .roundedLg
                            .color(whiteColor.withOpacity(0.5))
                            .width(300.w)
                            .height(45.h)
                            .make(),
                        10.heightBox,
                      ],
                    ),
                  )
                ],
              )
                  .box
                  .width(double.infinity)
                  .color(const Color(0xffFFC755))
                  .make(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/car.png",
                          width: 250.w,
                          fit: BoxFit.cover,
                        ),
                        10.heightBox,
                        Image.asset(
                          "assets/images/gift.png",
                          width: 250.w,
                          fit: BoxFit.cover,
                        ),
                        10.heightBox,
                        Image.asset(
                          "assets/images/call.png",
                          width: 250.w,
                          fit: BoxFit.cover,
                        ),
                        10.heightBox,
                        Image.asset(
                          "assets/images/like.png",
                          width: 250.w,
                          fit: BoxFit.cover,
                        ),
                        10.heightBox,
                      ],
                    ),
                  )
                ],
              ).box.color(const Color(0xfff9f3ea)).width(double.infinity).make()
            ],
          ),
        ),
      ),
    );
  }
}
