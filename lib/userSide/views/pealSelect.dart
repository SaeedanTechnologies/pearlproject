// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ImageGridScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Grid Screen'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('productImages').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No images available.'));
//           }

//           final imageUrls = snapshot.data!.docs.map((doc) => doc['producImage'].toString()).toList();

//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//             itemCount: imageUrls.length,
//             itemBuilder: (context, index) {
//               return Image.network(imageUrls[index], fit: BoxFit.cover);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ImagePickerScreen extends StatefulWidget {
//   @override
//   _ImagePickerScreenState createState() => _ImagePickerScreenState();
// }

// class _ImagePickerScreenState extends State<ImagePickerScreen> {
//   String? droppedImage;
//   List<String> firestoreImages = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchFirestoreImages();
//   }

//   Future<void> fetchFirestoreImages() async {
//     final snapshot = await FirebaseFirestore.instance.collection('productImages').get();
//     firestoreImages = snapshot.docs.map((doc) => doc['producImage'] as String).toList();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker & Drag/Drop'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 200.0,
//             color: const Color.fromRGBO(158, 158, 158, 1),
//             child: Center(
//               child: droppedImage != null
//                   ? Image.network(droppedImage!)
//                   : Text("Drop Images Here"),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: firestoreImages.length,
//               itemBuilder: (context, index) {
//                 final imageUrl = firestoreImages[index];
//                 return Draggable(
//                   data: imageUrl,
//                   child: Image.network(imageUrl),
//                   feedback: Image.network(imageUrl, width: 50, height: 50),
//                   childWhenDragging: Image.network(imageUrl, width: 50, height: 50),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:pearl/adminPanel/adminHome.dart';

// import 'quote.dart';

// class ImagePickerScreen extends StatefulWidget {
//   String? gender;
//   String? category;
//   String? size;

//   ImagePickerScreen(
//       {required this.category, required this.gender, required this.size});
//   @override
//   _ImagePickerScreenState createState() => _ImagePickerScreenState();
// }

// class _ImagePickerScreenState extends State<ImagePickerScreen> {
//   List<Positioned> droppedImages = [];
//   List<String> selectedImages = [];
//   Offset? _position;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Pearls'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 200.0,
//             color: Colors.grey,
//             child: Stack(
//               children: droppedImages,
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('productImages')
//                   .where("category", isEqualTo: controller.selectedCategory.value)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final pearlImages = snapshot.data!.docs
//                     //  .where((doc) => doc['category'] == 'pearl')
//                     .map((doc) => doc['producImage'] as String)
//                     .toList();

//                 return ListView.builder(
//                   itemCount: pearlImages.length,
//                   itemBuilder: (context, index) {
//                     final imageUrl = pearlImages[index];
//                     return Draggable(
//                       data: imageUrl,
//                       feedback: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           imageUrl,
//                         ),
//                       ),
//                       childWhenDragging: CircleAvatar(
//                         backgroundImage: NetworkImage(imageUrl),
//                       ),
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(imageUrl),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Confirm'),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(() => QuoteScreen(
//                       gender: controller.selectedGender.value,
//                       category: controller.selectedCategory.value,
//                       size: controller.selectSize.value));
//                 },
//                 child: Image.asset(
//                   'assets/images/arrow-slider.png', // Replace with your image path
//                   width: 50,
//                   height: 50,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_drag_and_drop/flutter_drag_and_drop.dart';
// import 'package:flutter_drag_target/flutter_drag_target.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ImagePickerScreen(),
//     );
//   }
// }

// class ImagePickerScreen extends StatefulWidget {
//   @override
//   _ImagePickerScreenState createState() => _ImagePickerScreenState();
// }

// class _ImagePickerScreenState extends State<ImagePickerScreen> {
//   List<String> draggedImages = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker & Drag/Drop'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 200.0, // Adjust the height as needed
//             child: DragAndDropGridView(
//               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 150.0,
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//               ),
//               itemCount: draggedImages.length,
//               onReorder: (oldIndex, newIndex) {
//                 setState(() {
//                   final String item = draggedImages[oldIndex];
//                   draggedImages.insert(newIndex, item);
//                 });
//               },
//               builder: (context, index) {
//                 return DragAndDropItem(
//                   child: Image.network(draggedImages[index]),
//                 );
//               },
//             ),
//           ),
//           DragTarget<String>(
//             builder: (context, accepted, rejected) {
//               return Container(
//                 height: 300, // Adjust the size as needed
//                 color: Colors.grey,
//                 child: Center(
//                   child: accepted.isEmpty
//                       ? Text("Drop Images Here")
//                       : Image.network(accepted.first!),
//                 ),
//               );
//             },
//             onWillAccept: (data) {
//               return true;
//             },
//             onAccept: (data) {
//               setState(() {
//                 draggedImages.remove(data);
//               });
//             },
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection('productImages').snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 List<String> firestoreImages = snapshot.data.docs
//                     .map((doc) => doc['imageUrl'] as String)
//                     .toList();

//                 return ListView.builder(
//                   itemCount: firestoreImages.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text('Image $index'),
//                       onTap: () {
//                         setState(() {
//                           draggedImages.add(firestoreImages[index]);
//                         });
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pearl/userSide/controller/categoryController.dart';
import 'package:pearl/userSide/views/quote.dart';
import 'package:pearl/widgets/pearlCustomBtn.dart';
import 'package:pearl/widgets/targetPearlWidget.dart';

// ignore: must_be_immutable
class ImagePickerScreen extends StatefulWidget {
  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class PearlData {
  final String image;
  final String documentId;

  PearlData({required this.image, required this.documentId});
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  var image1 = "".obs,
      image2 = "".obs,
      image3 = "".obs,
      image4 = "".obs,
      image5 = "".obs,
      image6 = "".obs,
      image7 = "".obs,
      image8 = "".obs,
      image9 = "".obs,
      image10 = "".obs,
      image11 = "".obs,
      image12 = "".obs;
  Color color = Colors.black;
  var docId = "";
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectCategoryController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 218, 218),
      appBar: AppBar(
        title: const Text("Image Picker & Drag/Drop"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: width,
              height: 300.h,
              child: controller.selectedCategory.value == 'Bracelet'
                  ? Stack(children: [
                      Image.asset(
                        "assets/images/bracelet-mixte.png",
                        fit: BoxFit.cover,
                      ),
                      targetPearlWidget(
                          left: 90,
                          top: 35,
                          right: 0,
                          bottom: 0,
                          image: image1,
                          pearlwidth: 25,
                          pearlheight: 25),
                      targetPearlWidget(
                          left: 76,
                          top: 97,
                          right: 0,
                          bottom: 0,
                          image: image2,
                          pearlwidth: 25,
                          pearlheight: 25),
                      targetPearlWidget(
                          left: 80,
                          top: 55,
                          right: 0,
                          bottom: 0,
                          image: image3,
                          pearlwidth: 25,
                          pearlheight: 25),
                      targetPearlWidget(
                          left: 76,
                          top: 77,
                          right: 0,
                          bottom: 0,
                          image: image4,
                          pearlwidth: 25,
                          pearlheight: 25),
                      targetPearlWidget(
                          left: 80,
                          top: 117,
                          right: 0,
                          bottom: 0,
                          image: image5,
                          pearlwidth: 25,
                          pearlheight: 25),
                      targetPearlWidget(
                          left: 88,
                          top: 137,
                          right: 0,
                          bottom: 0,
                          image: image6,
                          pearlwidth: 25,
                          pearlheight: 25),
                    ])
                  : controller.selectedCategory.value == 'Necklace'
                      ? Stack(children: [
                          Center(
                            child: Image.asset(
                              "assets/images/collier-femme-36.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          targetPearlWidget(
                              top: 92,
                              right: 112,
                              bottom: 0,
                              image: image1,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 107,
                              right: 125,
                              bottom: 0,
                              image: image2,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 120,
                              right: 140,
                              bottom: 0,
                              image: image3,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 130,
                              right: 156,
                              bottom: 0,
                              image: image4,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 135,
                              right: 175,
                              bottom: 0,
                              image: image5,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 130,
                              left: 142,
                              bottom: 0,
                              image: image6,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 120,
                              left: 125,
                              bottom: 0,
                              image: image7,
                              pearlwidth: 25,
                              pearlheight: 25),
                          targetPearlWidget(
                              top: 108,
                              left: 110,
                              bottom: 0,
                              image: image8,
                              pearlwidth: 25,
                              pearlheight: 25),
                        ])
                      : controller.selectedCategory.value == 'Ring'
                          ? Stack(children: [
                              Center(
                                child: Image.asset(
                                  "assets/images/bague-mixte.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              targetPearlWidget(
                                  top: 100,
                                  right: 120,
                                  bottom: 0,
                                  image: image1,
                                  pearlwidth: 40,
                                  pearlheight: 40),
                              targetPearlWidget(
                                  top: 80,
                                  right: 160,
                                  bottom: 0,
                                  image: image2,
                                  pearlwidth: 40,
                                  pearlheight: 40),
                              targetPearlWidget(
                                  top: 95,
                                  left: 125,
                                  bottom: 0,
                                  image: image3,
                                  pearlwidth: 40,
                                  pearlheight: 40),
                            ])
                          : controller.selectedCategory.value == 'BigJewls'
                              ? Stack(children: [
                                  Center(
                                    child: Image.asset(
                                      "assets/images/bijou-sac-6.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  targetPearlWidget(
                                      top: 113,
                                      right: 170,
                                      bottom: 0,
                                      image: image1,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      top: 133,
                                      right: 170,
                                      bottom: 0,
                                      image: image2,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      top: 173,
                                      right: 170,
                                      bottom: 0,
                                      image: image3,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      top: 153,
                                      right: 170,
                                      bottom: 0,
                                      image: image4,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      right: 155,
                                      bottom: 93,
                                      image: image5,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      right: 145,
                                      bottom: 75,
                                      image: image6,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      right: 155,
                                      bottom: 60,
                                      image: image7,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      right: 170,
                                      bottom: 50,
                                      image: image8,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      left: 150,
                                      bottom: 60,
                                      image: image9,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      left: 142,
                                      bottom: 80,
                                      image: image10,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                  targetPearlWidget(
                                      left: 150,
                                      bottom: 95,
                                      image: image11,
                                      pearlwidth: 25,
                                      pearlheight: 25),
                                ])
                              : controller.selectedCategory.value == 'Earrings'
                                  ? Stack(children: [
                                      Center(
                                        child: Image.asset(
                                          "assets/images/boucle-oreille-6.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      targetPearlWidget(
                                          top: 85,
                                          right: 143,
                                          bottom: 0,
                                          image: image1,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          top: 110,
                                          right: 143,
                                          bottom: 0,
                                          image: image2,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          top: 135,
                                          right: 143,
                                          bottom: 0,
                                          image: image3,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          top: 165,
                                          right: 143,
                                          bottom: 0,
                                          image: image4,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          bottom: 85,
                                          right: 143,
                                          image: image5,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          bottom: 60,
                                          right: 143,
                                          image: image6,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          bottom: 60,
                                          left: 135,
                                          image: image7,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          bottom: 85,
                                          left: 135,
                                          image: image8,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          bottom: 113,
                                          left: 135,
                                          image: image9,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          top: 137,
                                          left: 135,
                                          image: image10,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          top: 110,
                                          left: 135,
                                          image: image11,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                      targetPearlWidget(
                                          top: 85,
                                          left: 135,
                                          image: image12,
                                          pearlwidth: 25,
                                          pearlheight: 25),
                                    ])
                                  : const Center(),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('productImages')
                  .snapshots(),
              // .where("category", isEqualTo: controller.selectedCategory.value)
              // .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final pearlDataList = snapshot.data!.docs
                    //  .where((doc) => doc['category'] == 'pearl')
                    .map((doc) => doc['pearlImage'] as String)
                    .toList();
                return SizedBox(
                  height: 60.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pearlDataList.length,
                      itemBuilder: (context, index) {
                        final pearlData = pearlDataList[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: snapshot.data!.docs[index]['stock'] > 0 &&
                                  snapshot.data!.docs[index]['isDisable'] ==
                                      true
                              ? Draggable(
                                  onDragCompleted: () async {
                                    await FirebaseFirestore.instance
                                        .collection("productImages")
                                        .doc(snapshot.data!.docs[index].id)
                                        .update({
                                      "stock": FieldValue.increment(-1)
                                    });
                                  },
                                  data: pearlData,
                                  feedback: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      pearlData,
                                    ),
                                  ),
                                  childWhenDragging: CircleAvatar(
                                    backgroundImage:
                                        CachedNetworkImageProvider(pearlData),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        CachedNetworkImageProvider(pearlData),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        );
                      }),
                );
              }),
          pearCustomButton("Confirm", () {Get.to(()=>QuoteScreen());})
        ],
      ),
    );
  }
}
