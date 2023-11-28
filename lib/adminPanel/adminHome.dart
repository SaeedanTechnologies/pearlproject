import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pearl/adminPanel/awaitingAdmin.dart';
import 'package:pearl/loginScreen.dart';

import '../controller/userController.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}
// final picker = ImagePicker();

// Future<void> pickImageFromGallery() async {
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     // Upload the selected image to Firebase Storage
//    final  imageUrl = await uploadImageToStorage(File(pickedFile.path));

//     // Send a message with the image URL to Firestore
//     sendMessageWithImage(imageUrl);
//   }

// }

//  Future<String> uploadImageToStorage(File imageFile) async {
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   final Reference ref = storage.ref().child('chat_images/${DateTime.now().toString()}');
//   final UploadTask uploadTask = ref.putFile(imageFile);
//   final TaskSnapshot taskSnapshot = await uploadTask;
//   final imageUrl = await taskSnapshot.ref.getDownloadURL();
//   return imageUrl;
// }
//   final CollectionReference _code = FirebaseFirestore.instance.collection('pearlImages');

// void sendMessageWithImage(String imageUrl) async{

//    _code.add({

//        'image_url': imageUrl,

//     });

// }
List<DropdownMenuItem<String>> get category {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "ring", child: Text("ring")),
    const DropdownMenuItem(value: "bracelet", child: Text("bracelet")),
  ];
  return menuItems;
}

String cat = "ring";

class _AdminScreenState extends State<AdminScreen> {
  final ImagePicker _picker = ImagePicker();
  var imageFile;
  void selectImages() async {
    final XFile? images = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = images!;
    });

    if (images != null) {
      userController.imageFile = images.path == null ? "" : images.path;
      userController.update();
    }
  }

  Future<void>? _clear() {
    setState(
      () => _imageFile = null,
    );
  }

  XFile? _imageFile;
  UserController userController = Get.put(UserController());

  TextEditingController messageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<void>? alerts() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    // _pickImage(ImageSource.gallery);
                    selectImages();
                    Navigator.pop(context);
                    print("object");
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.browse_gallery),

                      //                Container(
                      // height: 40,
                      // width: 70,
                      // decoration: BoxDecoration(
                      //     color: Colors.black,
                      //     image: DecorationImage(image: AssetImage("assets/3.png"),fit: BoxFit.cover)),),
                      SizedBox(width: 5),
                      Text('Choose from Gallery '),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where("Qoutation", isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Row(
                    children: [Icon(Icons.notifications), Text('0')]);
              }

              if (snapshot.hasError) {
                return const Text('0');
              }

              if (snapshot.hasData) {
                int recordCount = snapshot.data!.docs.length;
                return GestureDetector(
                  onTap: () {
                    Get.to(() => AdminApproval());
                  },
                  child: Row(children: [
                    const Icon(Icons.notifications),
                    Text('$recordCount')
                  ]),
                );
              }

              return const Text('0');
            },
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await _firebaseAuth
                  .signOut()
                  .then((value) => Get.to(() => LoginScreen()));

              //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/flower.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await alerts();

                //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Enter discount coupon"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: couponController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Coupon Name"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Price"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: couponPriceController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "\$"),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("Discount Codes")
                      .doc()
                      .set({
                    "Discount Name": couponController.text.toString(),
                    "Price": couponPriceController.text.toString()
                  });
                },
                child: const Text(
                  "Add coupon",
                  style: TextStyle(color: Colors.black),
                )),
            // Center(child: GestureDetector(
            //       onTap: ()async{

            //       },
            //        child: Container(height: 30,width: 30,child: IconButton(
            //         onPressed: ()async {
            //             await alerts();
            //         },
            //        icon: Icon(Icons.upload_file)

            //        ),),
            //      ),),
            const SizedBox(
              height: 10,
            ),

            if (_imageFile != null) ...[
              Image.file(width: 200, height: 200, File(_imageFile!.path)),
              const Text('Message'),
              TextField(
                controller: messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Enter your message',
                  border: OutlineInputBorder(),
                ),
              ),

              const Text('Price'),
              TextField(
                controller: couponPriceController,
                keyboardType: TextInputType.number,
                //  maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Enter your price',
                  border: OutlineInputBorder(),
                ),
              ),

              DropdownButton(
                  value: cat,
                  onChanged: (String? newValue) {
                    setState(() {
                      cat = newValue!;
                    });
                  },
                  items: category),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // ElevatedButton(
                  //   child: Icon(Icons.crop),
                  //   onPressed: _cropImage,
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: _clear,
                    child: const Icon(
                      Icons.refresh,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Icon(
                      Icons.upload_file,
                    ),
                    onPressed: () async {
                      await userController.uploadFilesPassport(
                          _imageFile,
                          context,
                          messageController.text,
                          priceController.text,
                          cat);
                    },
                  ),
                ],
              ),

              // Uploader(file: _imageFile)
            ],
            /////    ElevatedButton(onPressed: (){}, child: Text("Upload Image")),
          ],
        ),
      ),
    );
  }

  final couponController = TextEditingController();
  final couponPriceController = TextEditingController();
}
