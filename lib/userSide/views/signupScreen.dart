import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/controller/authController.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pearl/userSide/controller/userController.dart';
import 'package:pearl/userSide/views/signupScreen.dart';
import 'package:pearl/widgets/customButton.dart';
import 'package:pearl/widgets/customtextfield.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignUpScreen extends StatelessWidget {
  UserController userController = Get.put(UserController());
  final loginController = Get.put(AuthController());

  String playerId = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bgimage.png"), fit: BoxFit.fitWidth)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              110.heightBox,
              Text(
                "SignUp",
                style: GoogleFonts.philosopher(
                    fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Username",
                      style: GoogleFonts.philosopher(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    customeTextField(
                        hinttext: "Johnsmith",
                        controller: loginController.emailController,
                        icon: Icons.person),
                    10.heightBox,
                    Text(
                      "Email",
                      style: GoogleFonts.philosopher(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    customeTextField(
                        hinttext: "Johnsmith@gmail.com",
                        controller: loginController.emailController,
                        icon: Icons.email),
                    10.heightBox,
                    Text(
                      "Gender",
                      style: GoogleFonts.philosopher(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    Obx(
                      () => Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.male,
                              color: apppurplecolor,
                            ),
                          ),
                          10.widthBox,
                          SizedBox(
                            height: 35.h,
                            child: DropdownButton<String>(
                              isDense: false,
                              value: loginController.selectedGender.value,
                              onChanged: (String? newValue) {
                                loginController.selectedGender.value =
                                    newValue!;
                              },
                              items: <String>[
                                'Male',
                                'Female'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      value,
                                      style: GoogleFonts.raleway(
                                          color: blackColor, fontSize: 15.sp),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                          .box
                          .color(whiteColor.withOpacity(0.7))
                          .withRounded(value: 10)
                          .make(),
                    ),
                    10.heightBox,
                    Text(
                      "Contact",
                      style: GoogleFonts.philosopher(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    customeTextField(
                        hinttext: "(+000)-1234-567",
                        controller: loginController.emailController,
                        icon: Icons.person),
                    10.heightBox,
                    Text(
                      "Password",
                      style: GoogleFonts.philosopher(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    customeTextField(
                        hinttext: "Password",
                        controller: loginController.passwordController,
                        icon: Icons.lock,
                        obsecure: true),
                    30.heightBox,
                    CustomButton(
                        buttonName: "SignUp",
                        onPressed: () {
                          userController.signInWithEmailAndPassword(
                              loginController.emailController.text
                                  .trim()
                                  .toString(),
                              loginController.passwordController.text
                                  .trim()
                                  .toString(),
                              context);
                        },
                        textcolor: apppurplecolor,
                        loading: false,
                        backgroundColor: appyellowColor,
                        rounded: false,
                        height: 40.h,
                        width: double.infinity),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "Or SignUp with",
                      style: GoogleFonts.raleway(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GoogleAuthButton(
                          style: const AuthButtonStyle(
                            iconType: AuthIconType.secondary,
                            buttonType: AuthButtonType.icon,
                          ),
                          onPressed: () {
                            loginController.googleSignIn();
                          },
                        ),
                        10.widthBox,
                        AppleAuthButton(
                          style: const AuthButtonStyle(
                            iconType: AuthIconType.secondary,
                            buttonType: AuthButtonType.icon,
                          ),
                          onPressed: () async {
                            final credential =
                                await SignInWithApple.getAppleIDCredential(
                              scopes: [
                                AppleIDAuthorizationScopes.email,
                                AppleIDAuthorizationScopes.fullName,
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              30.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.philosopher(
                        fontSize: 15.sp, color: blackColor),
                  ),
                  Text(
                    "SignIn",
                    style: GoogleFonts.philosopher(
                        fontSize: 18.sp,
                        color: purpleColor,
                        fontWeight: FontWeight.bold),
                  ).onTap(() {
                    Get.back();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
