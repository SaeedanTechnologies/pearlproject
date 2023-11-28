<<<<<<< Updated upstream
import 'package:auth_buttons/auth_buttons.dart';
=======
>>>>>>> Stashed changes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
<<<<<<< Updated upstream
// import 'package:onesignal_flutter/onesignal_flutter.dart';
=======
>>>>>>> Stashed changes
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserController userController = Get.put(UserController());
<<<<<<< Updated upstream
=======
  late SharedPreferences _prefs;
>>>>>>> Stashed changes

  String playerId = "";

  Future<void> _signIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        userController.uid = userCredential.user!.uid;
        userController.update();

        CollectionReference records =
            FirebaseFirestore.instance.collection('users');

        Get.to(SiteEngineer());
      } else {
        // Handle sign-in failure (e.g., show an error message).
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-in failed. Please check your credentials.'),
          ),
        );
      }
    } catch (e) {
      // Handle other errors (e.g., network issues, etc.).
      print('Error signing in: $e');
    }
  }

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
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await userController.signInWithEmailAndPassword(
                    _emailController.text, _passwordController.text, context);
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SignUpScreen());
              },
              child: const Text('SignUp'),
<<<<<<< Updated upstream
=======
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: const Text('Sign in with Google'),
            ),
            // ElevatedButton(
            //   onPressed: _handleAppleSignIn,
            //   child: Text('Sign in with Apple'),
            // ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _handleSignOut,
              child: const Text('Sign out'),
>>>>>>> Stashed changes
            ),
            const SizedBox(
              height: 20,
            ),
            GoogleAuthButton(
              onPressed: () {
                _handleSignIn();
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
                  const SizedBox(
                    height: 20,
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

<<<<<<< Updated upstream
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => Get.to(() => HomeScreen()));
=======
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) {
        Get.to(() => HomeScreen());
      });
>>>>>>> Stashed changes
    } catch (error) {
      print(error);
    }
  }
<<<<<<< Updated upstream
=======

  _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  // _handleAppleSignIn() async {
  //   try {
  //     final result = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     print(result);
  //   } catch (error) {
  //     print(error);
  //   }
  // }
>>>>>>> Stashed changes
}
