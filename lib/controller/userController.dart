import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:image_picker/image_picker.dart';
import 'package:pearl/adminPanel/adminScreen.dart';
import 'package:pearl/tabBar.dart';
import 'package:pearl/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
class UserController extends GetxController {
 

 

//  SharedPreferences prefs =  SharedPreferences.getInstance();

//   action = prefs.getString('action'); 

  

var imageFile;
 String uid = "";

 String inOut = "";

 DateTime timeText = DateTime.now();
 int totalHours = 0;
int totalSum  =0;
 int total = 0;
 int tt =0;

 int totalMin = 0;
 // User? user;
 String gender = "";

 String category = "asd";
 String tenNumberGenerated(){
  var rndnumber="";
  var rnd= new Random();
  for (var i = 0; i < 10; i++) {
  rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
  print(rndnumber);
  return rndnumber;
}

    Future<UploadTask?> uploadFilesPassport(XFile? files,context) async {
  
    //await getIDo();
     String rand = await tenNumberGenerated();
//  var uniqueKeys = firebaseRef.collection("users");
//     var uniqueKey = firebaseRef.collection("users");
    if (files == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('productImage') 
        .child('${rand}.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': files.path},
    );
    EasyLoading.show();

    if (kIsWeb) {
      uploadTask = ref.putData(await files.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(files.path), metadata);

    await  uploadTask.whenComplete(() async {
        var uploadpaths = await uploadTask.snapshot.ref.getDownloadURL();
           FirebaseFirestore.instance.collection("productImages").add({
              
                "producImage":uploadpaths,
           

           });
              //  await SendMailss();
           Get.snackbar("Uploaded", "Upload successfully");
          //  Get.to(HomePage());
          // await   sendEmail();
          EasyLoading.dismiss();
        // Get.to(HomePage());
        
      });


    }
    
    // await ref.getDownloadURL().then((value) => updataIdCard(value));

    return Future.value(uploadTask);
  }








    List<DocumentSnapshot> documents = [];
    List news = [];
    String? role;
    String? userName;
    String? customerId;
  Future<dynamic> prepaid(String email) async {
    news.clear();
    documents.clear();
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo:email )
        .get();
    documents = result.docs;
    update();
    print(documents.length);
    if (documents.length > 0) {
      news.add(result.docs);
      print(news);
      print(documents.first["role"]);

      if (documents.first["role"] == "customer") {
        // accountsList[0].accountB = "";
        var ids = documents.first.id;
        role = documents.first["role"];
          email = documents.first["email"];
        // userName = documents.first["name"];
        // customerId = documents.first["customerId"];

       update();
     
        
        
      }
       else if (documents.first["role"] == "admin") {
        role = documents.first["role"];
       // userName = documents.first["name"];
       email = documents.first["email"];
       update();
     
    
      }

    
   
    } else {
      Get.snackbar(
        "Error",
        "user not Exsist ! Sign up First",
      );

      role = "nothing";
  
      update();
EasyLoading.dismiss();
    }
  }
final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
 
var useri;
  Users? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }

    return Users(user.uid, user.email, user.emailVerified);
  }


  Future<Users?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    EasyLoading.show();
  
   
     await prepaid(email);
      if (role == "customer") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     
     update();
  //  await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>SiteEngineer());
      return _userFromFirebase(credential.user);
      }

       else if (role == "admin") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
   // await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>AdminHome());
      return _userFromFirebase(credential.user);
      }

 


      

  else {
   Get.snackbar("User", "User not Exsist");
   EasyLoading.dismiss();
  }    
 
   
  }










}
