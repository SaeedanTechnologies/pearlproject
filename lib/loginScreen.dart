import 'package:auth_buttons/auth_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pearl/controller/loginController.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pearl/controller/userController.dart';
import 'package:pearl/homeScreen.dart';
import 'package:pearl/signupScreen.dart';
import 'package:pearl/tabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserController userController = Get.put(UserController());
  final loginController = Get.put(LoginController());

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
            TextField(
              controller: loginController.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: loginController.emailController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
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
