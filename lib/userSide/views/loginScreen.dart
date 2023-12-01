import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/controller/authController.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pearl/userSide/controller/userController.dart';
import 'package:pearl/userSide/views/signupScreen.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customeTextField(
                hinttext: "email",
                controller: loginController.emailController,
                icon: Icons.email),
            10.heightBox,
            customeTextField(
                hinttext: "Password",
                controller: loginController.passwordController,
                icon: Icons.lock,
                obsecure: true),
            10.heightBox,
            ElevatedButton(
              onPressed: () async {
                await userController.signInWithEmailAndPassword(
                    loginController.emailController.text.trim().toString(),
                    loginController.passwordController.text.trim().toString(),
                    context);
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SignUpScreen());
              },
              child: const Text('SignUp'),
            ),
            const SizedBox(
              height: 20,
            ),
            GoogleAuthButton(
              onPressed: () {
                loginController.googleSignIn();
              },
            ),
            SizedBox(
              width: 250,
              child: SignInWithAppleButton(
                onPressed: () async {
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );

                  // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                  // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
