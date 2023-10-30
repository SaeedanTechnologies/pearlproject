import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/const/const.dart';
import 'package:pearl/controller/controllerRef.dart';
import 'package:pearl/loginScreen.dart';
import 'package:pearl/nextScreen.dart';

class CategoryScreen extends StatefulWidget {
    String? genderss;
  CategoryScreen({this.genderss});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  String? category = "necklace";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Category Screen'),
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
                'Select Category',
                style: TextStyle(fontStyle: FontStyle.italic,color: purpleColor),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(value: 'necklace', groupValue: category, onChanged: (hm) {
                        setState(() {
                         category = hm;  
                        });
                        
                        
                       
                         
                      }),
                               Text('Necklace'),
                    ],
                  ),
         
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(value: 'bracelet', groupValue: category, onChanged: (hm) {
                           setState(() {
                         category = hm;  
                        });
                      }),
                           Text('Bracelet'),
                    ],
                  ),
             
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Radio(value: 'ring', groupValue: category, onChanged: (hm) {
                           setState(() {
                         category = hm;  
                        });
                  }),
                  
                   Text('Ring'),
                     ],
                   ),
                 
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Radio(value: 'bagJewel', groupValue: category, onChanged: (hm) {
                           setState(() {
                         category = hm;  
                        });
                  }),
                 
                   Text('Bag Jewel'),
                     ],
                   ),
                 
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Radio(value: 'earrings', groupValue: category, onChanged: (hm) {
                           setState(() {
                         category = hm;  
                        });
                  }),
                    Text('Earrings'),
                     ],
                   ),
                
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
                      Get.to(()=>NextScreen(genderss:widget.genderss,category:category));
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

