import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pearl/userSide/controller/userController.dart';
import 'package:pearl/userSide/model/user_model.dart';
import 'package:pearl/userSide/views/loginScreen.dart';
import 'package:pearl/userSide/views/tabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
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
  final genderController = TextEditingController();
  final nameController = TextEditingController();
  final userController = Get.put(UserController());
  Future<void> signIn(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: emailController.text.trim().toString(),
      );

      if (userCredential.user != null) {
        userController.uid = userCredential.user!.uid;
        userController.update();

        // CollectionReference records = firestore.collection('users');

        Get.to(() => TabBars());
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

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required context,
    required String gender,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        userController.uid = userCredential.user!.uid;
        userController.update();

        CollectionReference records =
            FirebaseFirestore.instance.collection('users');

        await records.doc(userController.uid).set(UserModel(
              userId: userCredential.user!.uid,
              userName:name,
              userAddress:"",
              userEmail: email,
              userGender: gender,
              isEmailVerified: userCredential.user!.emailVerified,
              
            ).toJson());

        // Create a new record document with the current user's ID and the status ("In" or "Out").

        //       List<DocumentSnapshot> documents = [];
        // List cardEx = [];

        // String? exCardB;

        //   documents.clear();

        //   final QuerySnapshot result = await FirebaseFirestore.instance
        //       .collection('users')
        //       .where('user_id', isEqualTo: username)

        //       .get();
        //   documents = result.docs;

        //   print(documents.length);
        //   if (documents.length > 0) {
        //     cardEx.add(result.docs);

        //     print(documents.first["inOut"]);

        //    userController.inOut  = documents.first["inOut"];
        //    userController.timeText =  documents.first["timeText"];
        //    userController.update();

        //   setState(() {

        //   });

        //   } else {
        //     Get.snackbar("Information Missing Or invalid",
        //         "Please write correct information ");

        //   }

        Get.to(LoginScreen());
        // Successfully signed in, navigate to the home screen or perform other actions.
        // You can use Navigator to navigate to the next screen.
        // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
  Future<void> googleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => Get.to(() => TabBars()));
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
