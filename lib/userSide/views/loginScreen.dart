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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              const Spacer(),
              Text(
                "Login",
                style: GoogleFonts.philosopher(
                    fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              20.heightBox,
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
              20.heightBox,
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
                  buttonName: "SignIn",
                  onPressed: () {
                    userController.signInWithEmailAndPassword(
                        loginController.emailController.text.trim().toString(),
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
                "Or SignIn with",
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
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.philosopher(
                        fontSize: 15.sp, color: blackColor),
                  ),
                  Text(
                    "SignUp",
                    style: GoogleFonts.philosopher(
                        fontSize: 18.sp,
                        color: purpleColor,
                        fontWeight: FontWeight.bold),
                  ).onTap(() {Get.to(()=>SignUpScreen());}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
