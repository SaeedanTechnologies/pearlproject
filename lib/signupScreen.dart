

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pearl/controller/userController.dart';
import 'package:pearl/homeScreen.dart';
import 'package:pearl/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   UserController userController = Get.put(UserController());
  Future<void> _signIn() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
         userController.uid = userCredential.user!.uid;
         userController.update();

          CollectionReference records =
          FirebaseFirestore.instance.collection('users');


          await records.doc(userController.uid).set({
        'user_id': userController.uid,
        'email': email,
        'role': "customer", 
        
      });

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
          SnackBar(
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
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('SignUp'),
            ),
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
}
