
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay/pay.dart';
import 'package:pearl/controller/userController.dart';

class QuoteScreen extends StatefulWidget {
  String? gender;

  String? category;

  String? size;

  QuoteScreen(
      {required this.category, required this.gender, required this.size});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  void onGooglePayResult(paymentResult) async {}

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController accessoryTypeController = TextEditingController();
  TextEditingController measureController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController modelScreenshotController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  // Assuming you've previously obtained the 'user' object from Firebase authentication
  // and the Firestore 'orders' collection reference
//   void submitOrder() async {

//     final newOrder = {
//       'name': nameController.text,
//       'phoneNumber': phoneNumberController.text,
//       'email': emailController.text,
//       'accessoryType': accessoryTypeController.text,
//       'measure': measureController.text,
//       'modelScreenshot': userController.imageFile,
//       'message': messageController.text,
//     };
// //     final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
// // final auth.User user = _firebaseAuth.currentUser!;
// //      userEmailUid = credential.user!.uid;
// //      update();
//     FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders').add(newOrder);
//   }

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

  UserController userController = Get.put(UserController());
  XFile? _imageFile;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Quote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/flower.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                const Text('Name'),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text('Phone Number'),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text('Email'),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Text('Gender'),
                TextField(
                  controller: genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.gender,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Text('Accessory Type'),
                TextField(
                  controller: accessoryTypeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.category,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Text('Measure'),
                TextField(
                  controller: measureController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.size,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Text('Model Screen Shot'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await alerts();
                      // Handle image upload
                    },
                    child: const Text('Upload Image'),
                  ),
                ),
                const Text('Message'),
                TextField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(),
                  ),
                ),
                GooglePayButton(
                  paymentConfigurationAsset:
                      "sample_payment_configuration.json",
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // submitOrder();
                      // await userController.uploadFilesForOrder(
                      //     _imageFile,
                      //     context,
                      //     nameController.text,
                      //     phoneNumberController.text,
                      //     emailController.text,
                      //     widget.gender!,
                      //     widget.category!,
                      //     widget.size!,
                      //     messageController.text);
                      var price = await FirebaseFirestore.instance
                          .collection("users")
                          .doc(auth.FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((value) => value['total_points']);
                      var newprice = 200 + price;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(auth.FirebaseAuth.instance.currentUser!.uid)
                          .set({"total_points": newprice},
                              SetOptions(merge: true));
                    },
                    child: const Text('Ask for Quote'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
