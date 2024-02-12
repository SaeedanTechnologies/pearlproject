import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pearl/adminPanel/adminScreen.dart';
import 'package:pearl/tabBar.dart';
import 'package:pearl/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

class UserController extends GetxController {
  Future sendQuotation(String name, String docId) async {
    await FirebaseFirestore.instance.collection('orders').doc(docId).update({
      "price": name,
      "Qoutation": true,
    });
  }

//  SharedPreferences prefs =  SharedPreferences.getInstance();

//   action = prefs.getString('action');

  var imageFile;
  String uid = "";

  String inOut = "";

  DateTime timeText = DateTime.now();
  int totalHours = 0;
  int totalSum = 0;
  int total = 0;
  int tt = 0;

  int totalMin = 0;
  // User? user;
  String gender = "";

  String category = "asd";
  String tenNumberGenerated() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 10; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    print(rndnumber);
    return rndnumber;
  }

  Future<UploadTask?> uploadFilesPassport(
      XFile? files, context, String message, String price, String cat) async {
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

      await uploadTask.whenComplete(() async {
        var uploadpaths = await uploadTask.snapshot.ref.getDownloadURL();
        FirebaseFirestore.instance.collection("productImages").add({
          "producImage": uploadpaths,
          "description": message,
          "price": price,
          "category": cat
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

  Future<UploadTask?> uploadFilesForOrder(
      XFile? files,
      context,
      String name,
      String phoneNumber,
      String email,
      String gender,
      String accessary,
      String measure,
      String message) async {
    final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
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
        .child('orderImages')
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

      await uploadTask.whenComplete(() async {
        var uploadpaths = await uploadTask.snapshot.ref.getDownloadURL();

        final newOrder = {
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'accessoryType': accessary,
          'measure': measure,
          'modelScreenshot': uploadpaths,
          'message': message,
          "Qoutation": false,
          "price": "",
          "userid": _firebaseAuth.currentUser!.uid,
          "docId": ""
        };

        // DocumentReference ref = await FirebaseFirestore.instance.collection('users').doc(_firebaseAuth.currentUser!.uid).collection('orders').add(newOrder);

        // await FirebaseFirestore.instance.collection('users').doc(_firebaseAuth.currentUser!.uid).collection('orders').doc(ref.id).update({
        //  "docid":ref.id
        // });

        DocumentReference refs =
            await FirebaseFirestore.instance.collection('orders').add(newOrder);
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(refs.id)
            .update({"docid": refs.id});
        //  FirebaseFirestore.instance.collection("users").doc().collection("orders").add({

        //       "producImage":uploadpaths,

        //  });

        //  sendNotificationToPlayer("6fbbc31d-fb5d-4d8f-bc0b-5fd4aeb2d9b8", "Your notification message");

        //  await SendMailss();
        Get.snackbar("Uploaded", "Upload successfully");
        Get.to(() => SiteEngineer());
        //  Get.to(HomePage());
        // await   sendEmail();
        EasyLoading.dismiss();
        // Get.to(HomePage());
      });
    }

    // await ref.getDownloadURL().then((value) => updataIdCard(value));

    return Future.value(uploadTask);
  }

  void sendNotificationToPlayer(String playerId, String message) async {
    final apiKey = "MTRmMzIzZWEtY2M3OS00MzY0LWI3YmYtZjE1ZDY3ZmM0OWZi";
    final appId = "aad95b11-e195-4149-b679-a947d489facc";

    final url = Uri.https("https://onesignal.com/api/v2/notifications");
    final headers = {
      "content-type": "application/json; charset=UTF-8",
      "Authorization": "Basic $apiKey",
      "accept": "application/json"
    };

    final body = {
      "app_id": appId,
      "include_player_ids": [playerId],
      "contents": {"en": message},
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification: ${response.body}");
    }
  }

// Future sendNotification(List<String> tokenIdList, String contents, String heading) async{

//     return await post(
//       Uri.parse('https://onesignal.com/api/v1/notifications'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>
//       {
//         "app_id": kAppId,//kAppId is the App Id that one get from the OneSignal When the application is registered.

//         "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

//           // android_accent_color reprsent the color of the heading text in the notifiction
//         "android_accent_color":"FF9976D2",

//         "small_icon":"ic_stat_onesignal_default",

//         "large_icon":"https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

//         "headings": {"en": heading},

//         "contents": {"en": contents},

//       }),
//     );
//   }

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
        .where('email', isEqualTo: email)
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
      } else if (documents.first["role"] == "admin") {
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

  var playerId;

  Future getPlayerId() async {
    try {
      var deviceState = await OneSignal.User;

      if (deviceState == null || deviceState.pushSubscription.id == null)
        return;

      playerId = deviceState.pushSubscription.id!;
      update();

      print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" + playerId);
      //await  updateToken();
    } catch (e) {
      Get.snackbar("title", "not getting PlayerID  ${e}");
    }
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
      Get.to(() => SiteEngineer());
      return _userFromFirebase(credential.user);
    } else if (role == "admin") {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      useri = credential.user!.uid;
      update();
      // await notificationController.getPlayerId();
      await getPlayerId();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(useri)
          .update({"playerId": playerId});

      EasyLoading.dismiss();
      Get.to(() => AdminHome());
      return _userFromFirebase(credential.user);
    } else {
      Get.snackbar("User", "User not Exsist");
      EasyLoading.dismiss();
    }
  }
}
