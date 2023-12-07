import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/views/landingpage/the_Concept.dart';
import 'package:pearl/userSide/views/loginScreen.dart';
import 'package:pearl/userSide/views/marketplace.dart';
import 'package:pearl/widgets/pearlCustomBtn.dart';
import 'package:velocity_x/velocity_x.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: const Color(0xFFF9F3EA),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Image.asset("assets/images/magic-stone 2.png"),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  "THE CONCEPT".text.black.make().onTap(() {
                    Get.to(() => const TheConcept());
                  }),
                  "CATALOGE".text.black.make().onTap(() {
                    Get.to(() => CatalogScreen());
                  }),
                  "CREATE JEWLS".text.black.make().onTap(() {
                    Get.to(() => LoginScreen());
                  })
                ],
              )
                  .box
                  .color(const Color.fromRGBO(255, 199, 85, 1))
                  .height(40.h)
                  .make(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "MagicStone\nBreadworks",
                              style: GoogleFonts.italiana(
                                  fontSize: 40.sp, color: blackColor),
                            )),
                        20.heightBox,
                        Image.asset("assets/images/img1.png"),
                        20.heightBox,
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome !",
                                  style: GoogleFonts.philosopher(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: blackColor),
                                ),
                                20.heightBox,
                                Text(
                                  "Discover 350+ bead varieties at the South- West pearl factory, including gemstones, mother-of- pearl, shells, coconut, wood, ceramic, crystal beads, and more.",
                                  style: GoogleFonts.raleway(
                                      wordSpacing: 1,
                                      fontSize: 15.sp,
                                      color: blackColor),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            )),
                        20.heightBox,
                        pearCustomButton(
                            "Learn more", () => Get.to(() => TheConcept())),
                        20.heightBox,
                      ],
                    ),
                  )
                ],
              )
                  .box
                  .color(Colors.grey.withOpacity(0.3))
                  .width(double.infinity)
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
