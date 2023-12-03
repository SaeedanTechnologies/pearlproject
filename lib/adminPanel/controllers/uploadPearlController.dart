import 'dart:io';
import 'dart:math';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pearl/adminPanel/models/addpearlModel.dart';

class UploadPearlsController extends GetxController {
  TextEditingController messageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController pearlNameController = TextEditingController();
  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  var imagePath = "".obs;

  void selectImages() async {
    final XFile? images = await _picker.pickImage(source: ImageSource.gallery);
    if (images != null) {
      selectedImage.value = images;
      imagePath.value = images.path;

    }
  }

  String tenNumberGenerated() {
    var rndnumber = "";
    var rnd = Random();
    for (var i = 0; i < 10; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }

    return rndnumber;
  }

  Future<UploadTask?> uploadNewPearl(XFile? files, context, String message,
      int price, int stock, String pearlName) async {
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
        FirebaseFirestore.instance.collection("productImages").add(
            UploadPearlModel(
                    pearlName: pearlName,
                    pearlImage: uploadpaths,
                    pearlDescription: message,
                    pearlPrice: price,
                    stock: stock)
                .toJson());
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
}
