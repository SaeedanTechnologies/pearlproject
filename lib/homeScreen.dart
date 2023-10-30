import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/categoryScreen.dart';
import 'package:pearl/const/const.dart';
import 'package:pearl/controller/controllerRef.dart';
import 'package:pearl/loginScreen.dart';
import 'package:pearl/nextScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  String? genders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Screen'),
        actions: [
           ElevatedButton(
                onPressed: ()async {
                  await  _firebaseAuth.signOut().then((value) => Get.to(()=>LoginScreen()));
                  
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
                },
                child: Text('Logout'),
              ),
        
        ],
      ),
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/flower.jpg"),fit: BoxFit.cover)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This command is for',
                style: TextStyle(fontStyle: FontStyle.italic,color: purpleColor),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 'male', groupValue: genders, onChanged: (hm) {
                    setState(() {
                     genders = hm;  
                    });
                    
                    
                   
                     
                  }),
                  Text('Male'),
                  Radio(value: 'female', groupValue: genders, onChanged: (hm) {
                       setState(() {
                     genders = hm;  
                    });
                  }),
                  Text('Female'),
                ],
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              // //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
              //   },
              //   child: Text('Continue'),
              // ),
           
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Confirm"),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>CategoryScreen(genderss:genders));
                    },
                    child: Image.asset(
                      'assets/images/arrow-slider.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

