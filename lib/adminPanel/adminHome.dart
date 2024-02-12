import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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

class _AdminScreenState extends State<AdminScreen> {
  String selectedCategory = "earrings";
  String? selectedPrice;
  List<String> category = ["bracelet", "necklace", "earrings", "ring"];
  List<String> earringprices = [
    "\$34 - Price 1",
    "\$44 - Price 2",
    "\$54 - Price 3",
    "\$64 - Price 4",
    "\$94 - Price 5",
  ];
  List<String> necklaceprices = [
    "\$49 - Price 1",
    "\$59 - Price 2",
    "\$69 - Price 3",
    "\$79 - Price 4",
    "\$119 - Price 5",
  ];
  List<String> braceletprices = [
    "\$34 - Price 1",
    "\$44 - Price 2",
    "\$54 - Price 3",
    "\$64 - Price 4",
    "\$94 - Price 5"
  ];
  List<String> ringprices = [
    "\$24 - Price 1",
    "\$34 - Price 2",
    "\$44 - Price 3",
    "\$54 - Price 4",
    "\$74 - Price 5"
  ];

  // Add more categories and prices as needed
  List<Color> color = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.white,
    Colors.black,
    Colors.grey,
    Colors.brown,
  ];
  final ImagePicker _picker = ImagePicker();
  int selectedColor = 0;
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
      resizeToAvoidBottomInset: false,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await alerts();

                  //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
                },
                child: const Text('Upload Image'),
              ),
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

                const SizedBox(
                  height: 20,
                ),
                // DropdownButton<String>(
                //   value: selectedCategory,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedCategory = newValue!;
                //     });
                //   },
                //   items: category.map((String category) {
                //     return DropdownMenuItem<String>(
                //       value: category,
                //       child: Text(category),
                //     );
                //   }).toList(),
                //   hint: const Text('Select Category'),
                // ),
                // const SizedBox(height: 20),
                // selectedCategory == "earrings"
                //     ? DropdownButton<String>(
                //         value: selectedPrice,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             selectedPrice = newValue!;
                //           });
                //         },
                //         items: earringprices.map((String price) {
                //           return DropdownMenuItem<String>(
                //             value: price,
                //             child: Text(price),
                //           );
                //         }).toList(),
                //         hint: const Text('Select Price'),
                //       )
                //     : selectedCategory == "necklace"
                //         ? DropdownButton<String>(
                //             value: selectedPrice,
                //             onChanged: (String? newValue) {
                //               setState(() {
                //                 selectedPrice = newValue!;
                //               });
                //             },
                //             items: necklaceprices.map((String price) {
                //               return DropdownMenuItem<String>(
                //                 value: price,
                //                 child: Text(price),
                //               );
                //             }).toList(),
                //             hint: const Text('Select Price'),
                //           )
                //         : selectedCategory == "ring"
                //             ? DropdownButton<String>(
                //                 value: selectedPrice,
                //                 onChanged: (String? newValue) {
                //                   setState(() {
                //                     selectedPrice = newValue!;
                //                   });
                //                 },
                //                 items: ringprices.map((String price) {
                //                   return DropdownMenuItem<String>(
                //                     value: price,
                //                     child: Text(price),
                //                   );
                //                 }).toList(),
                //                 hint: const Text('Select Price'),
                //               )
                //             : selectedCategory == "bracelet"
                //                 ? DropdownButton<String>(
                //                     value: selectedPrice,
                //                     onChanged: (String? newValue) {
                //                       setState(() {
                //                         selectedPrice = newValue!;
                //                       });
                //                     },
                //                     items: braceletprices.map((String price) {
                //                       return DropdownMenuItem<String>(
                //                         value: price,
                //                         child: Text(price),
                //                       );
                //                     }).toList(),
                //                     hint: const Text('Select Price'),
                //                   )
                //                 : const Center(),

                const Text('Message'),
                TextField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Select Color")),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: color.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selectedColor = index;
                              setState(() {});
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: selectedColor == index
                                      ? Border.all(width: 2)
                                      : Border(),
                                  color: color[index],
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          )),
                ),

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
                            selectedPrice!,
                            selectedCategory);
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
      ),
    );
  }
}
