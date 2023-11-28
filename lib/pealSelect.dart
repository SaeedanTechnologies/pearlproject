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
//                   .where("category", isEqualTo: widget.category)
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
//                       gender: widget.gender,
//                       category: widget.category,
//                       size: widget.size));
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/quote.dart';

// ignore: must_be_immutable
class ImagePickerScreen extends StatefulWidget {
  ImagePickerScreen(
      {super.key,
      required this.gender,
      required this.category,
      required this.size});
  String? gender;
  String? category;
  String? size;

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  var image1,
      image2,
      image3,
      image4,
      image5,
      image6,
      image7,
      image8,
      image9,
      image10,
      image11,
      image12;
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height * .5;

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
            child: Container(
              width: width,
              height: height,
              child: widget.category == 'bracelet'
                  ? Stack(
                      children: [
                        Image.asset(
                          "assets/images/bracelet-mixte.png",
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 100,
                          top: 40,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              DragTarget<String>(
                                onAccept: (data) => setState(() {
                                  image1 = data;
                                }),
                                builder: (builder, _, __) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: color,
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: image1 != null
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              image1 = null;
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              image1,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: 83,
                          top: 110,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              DragTarget<String>(
                                onAccept: (data) => setState(() {
                                  image2 = data;
                                }),
                                builder: (builder, _, __) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: color,
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: image2 != null
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              image2 = null;
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              image2,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 88,
                          top: 62,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              DragTarget<String>(
                                  onAccept: (data) => setState(() {
                                        image3 = data;
                                      }),
                                  builder: (builder, _, __) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: color,
                                        ),
                                        width: 25,
                                        height: 25,
                                        child: image3 != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    image3 = null;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    image3,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ))
                            ],
                          ),
                        ),
                        Positioned(
                          left: 84,
                          top: 86,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              DragTarget<String>(
                                  onAccept: (data) => setState(() {
                                        image4 = data;
                                      }),
                                  builder: (builder, _, __) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: color,
                                        ),
                                        width: 25,
                                        height: 25,
                                        child: image4 != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    image4 = null;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    image4,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ))
                            ],
                          ),
                        ),
                        Positioned(
                          left: 86,
                          top: 134,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              DragTarget<String>(
                                  onAccept: (data) => setState(() {
                                        image5 = data;
                                      }),
                                  builder: (builder, _, __) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: color,
                                        ),
                                        width: 25,
                                        height: 25,
                                        child: image5 != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    image5 = null;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    image5,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ))
                            ],
                          ),
                        ),
                        Positioned(
                          left: 95,
                          top: 156,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              DragTarget<String>(
                                  onAccept: (data) => setState(() {
                                        image6 = data;
                                      }),
                                  builder: (builder, _, __) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: color,
                                        ),
                                        width: 25,
                                        height: 25,
                                        child: image6 != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    image6 = null;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    image6,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ))
                            ],
                          ),
                        ),
                      ],
                    )
                  : widget.category == "necklace"
                      ? Stack(
                          children: [
                            Image.asset(
                              "assets/images/collier-femme-36.png",
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 132,
                              top: 125,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image1 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image1 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image1 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image1,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              right: 146,
                              top: 144,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image2 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image2 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image2 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image2,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              right: 165,
                              top: 160,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image3 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image3 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image3 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image3,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              right: 185,
                              top: 175,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image4 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image4 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image4 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image4,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              right: 185,
                              top: 175,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image5 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image5 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image5 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image5,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              left: 158,
                              top: 180,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image6 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image6 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image6 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image6,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              left: 135,
                              top: 173,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image7 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image7 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image7 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image7,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              left: 115,
                              top: 163,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image8 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image8 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image8 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image8,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                            Positioned(
                              left: 99,
                              top: 146,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  DragTarget<String>(
                                      onAccept: (data) => setState(() {
                                            image9 = data;
                                          }),
                                      builder: (builder, _, __) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color,
                                            ),
                                            width: 25,
                                            height: 25,
                                            child: image9 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        image9 = null;
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        image9,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ))
                                ],
                              ),
                            ),
                          ],
                        )
                      : widget.category == 'ring'
                          ? Center(
                              child: Stack(children: [
                                Image.asset(
                                  "assets/images/bague-mixte.png",
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  left: 50,
                                  top: 50,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      DragTarget<String>(
                                          onAccept: (data) => setState(() {
                                                image1 = data;
                                              }),
                                          builder: (builder, _, __) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: color,
                                                ),
                                                width: 40,
                                                height: 40,
                                                child: image1 != null
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            image1 = null;
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            image1,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 95,
                                  top: 30,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      DragTarget<String>(
                                          onAccept: (data) => setState(() {
                                                image2 = data;
                                              }),
                                          builder: (builder, _, __) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: color,
                                                ),
                                                width: 40,
                                                height: 40,
                                                child: image2 != null
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            image2 = null;
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            image2,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 45,
                                  top: 55,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      DragTarget<String>(
                                          onAccept: (data) => setState(() {
                                                image3 = data;
                                              }),
                                          builder: (builder, _, __) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: color,
                                                ),
                                                width: 40,
                                                height: 40,
                                                child: image3 != null
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            image3 = null;
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            image3,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ))
                                    ],
                                  ),
                                ),
                              ]),
                            )
                          : widget.category == 'bagJewel'
                              ? Center(
                                  child: Stack(children: [
                                    Image.asset(
                                      "assets/images/bijou-sac-6.png",
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      left: 180,
                                      top: 145,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image1 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image1 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image1 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image1,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 180,
                                      top: 168,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image2 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image2 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image2 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image2,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 180,
                                      top: 190,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image3 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image3 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image3 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image3,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 180,
                                      bottom: 135,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image4 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image4 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image4 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image4,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 167,
                                      bottom: 122,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image5 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image5 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image5 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image5,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 160,
                                      bottom: 100,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image6 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image6 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image6 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image6,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 168,
                                      bottom: 78,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image7 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image7 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image7 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image7,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 186,
                                      bottom: 64,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image8 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image8 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image8 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image8,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 160,
                                      bottom: 75,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image9 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image9 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image9 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image9,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 155,
                                      bottom: 100,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image10 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image10 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image10 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image10,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 162,
                                      bottom: 122,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DragTarget<String>(
                                              onAccept: (data) => setState(() {
                                                    image11 = data;
                                                  }),
                                              builder: (builder, _, __) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: color,
                                                    ),
                                                    width: 25,
                                                    height: 25,
                                                    child: image11 != null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                image11 = null;
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                image11,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ]),
                                )
                              : widget.category == 'earrings'
                                  ? Center(
                                      child: Stack(children: [
                                        Image.asset(
                                          "assets/images/boucle-oreille-6.png",
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 153,
                                          top: 65,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image1 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image1 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image1 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image1,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 153,
                                          top: 97,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image2 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image2 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image2 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image2,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 153,
                                          top: 128,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image3 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image3 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image3 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image3,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 153,
                                          top: 159,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image4 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image4 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image4 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image4,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 153,
                                          bottom: 67,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image5 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image5 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image5 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image5,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 153,
                                          bottom: 35,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image6 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image6 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image6 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image6,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 147,
                                          top: 65,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image7 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image7 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image7 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image7,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 147,
                                          top: 97,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image8 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image8 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image8 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image8,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 147,
                                          top: 128,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image9 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image9 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image9 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image9,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 147,
                                          top: 159,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image10 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image10 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image10 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image10,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 147,
                                          bottom: 67,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image11 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image11 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image11 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image11,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 147,
                                          bottom: 35,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              DragTarget<String>(
                                                  onAccept: (data) =>
                                                      setState(() {
                                                        image12 = data;
                                                      }),
                                                  builder: (builder, _, __) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: color,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                        child: image12 != null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    image12 =
                                                                        null;
                                                                  });
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    image12,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ))
                                            ],
                                          ),
                                        ),
                                      ]),
                                    )
                                  : Center(),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('productImages')
                  .snapshots(),
              // .where("category", isEqualTo: widget.category)
              // .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final pearlImages = snapshot.data!.docs
                    //  .where((doc) => doc['category'] == 'pearl')
                    .map((doc) => doc['producImage'] as String)
                    .toList();
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pearlImages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Draggable(
                          data: pearlImages[index],
                          feedback: CircleAvatar(
                            child: Image.network(
                              pearlImages[index],
                            ),
                          ),
                          childWhenDragging: CircleAvatar(
                            backgroundImage: NetworkImage(pearlImages[index]),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(pearlImages[index]),
                          ),
                        ),
                      ),
                    ));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Confirm'),
              GestureDetector(
                onTap: () {
                  Get.to(() => QuoteScreen(
                      gender: widget.gender,
                      category: widget.category,
                      size: widget.size));
                },
                child: Image.asset(
                  'assets/images/arrow-slider.png', // Replace with your image path
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
