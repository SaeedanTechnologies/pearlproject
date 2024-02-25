import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:pearl/controller/userController.dart';
import 'package:pearl/signupScreen.dart';
import 'package:pearl/tabBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserController userController = Get.put(UserController());

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
            ),
            GooglePayButton(
                  // ignore: deprecated_member_use
                  paymentConfigurationAsset:
                      'sample_payment_configuration.json',
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.pay,
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '1.0',
      status: PaymentItemStatus.final_price,
    ),
  ];
  // In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) async {
    // Send the resulting Google Pay token to your server or PSP
    print(paymentResult);
   
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
}
