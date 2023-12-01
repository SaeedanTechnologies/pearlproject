import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pearl/userSide/controller/authController.dart';
import 'package:pearl/widgets/customtextfield.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customeTextField(
                hinttext: "email",
                controller: authController.emailController,
                icon: Icons.email),
            10.heightBox,
            customeTextField(
                hinttext: "email",
                controller: authController.emailController,
                icon: Icons.email),
            10.heightBox,
            customeTextField(
                hinttext: "Gender",
                controller: authController.genderController,
                icon: Icons.female,
                obsecure: true),
            10.heightBox,
            customeTextField(
                hinttext: "Password",
                controller: authController.passwordController,
                icon: Icons.lock,
                obsecure: true),
            10.heightBox,
            ElevatedButton(
              onPressed: () => authController.signUp(
                  name: authController.nameController.text.trim().toString(),
                  email: authController.emailController.text.trim().toString(),
                  password:
                      authController.passwordController.text.trim().toString(),
                  context: context,
                  gender:
                      authController.genderController.text.trim().toString()),
              child: const Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}
