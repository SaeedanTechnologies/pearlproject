import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:pearl/controller/userController.dart';
import 'package:pearl/homeScreen.dart';
import 'package:pearl/tabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final userController = Get.put(UserController());
  Future<void> signIn(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String email = _emailController.text.trim();
      // final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: emailController.text.trim().toString(),
      );

      if (userCredential.user != null) {
        userController.uid = userCredential.user!.uid;
        userController.update();

        CollectionReference records = firestore.collection('users');

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
 final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => Get.to(() => HomeScreen()));
    } catch (error) {
      print(error);
    }
  }

  _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }
  
}
