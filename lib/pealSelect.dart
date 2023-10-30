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





















import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  List<Positioned> droppedImages = [];
  List<String> selectedImages = [];
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Pearls'),
      ),
      body: Column(
        children: [
          Container(
            height: 200.0,
            color: Colors.grey,
            child: Stack(
              children: droppedImages,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('productImages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final pearlImages = snapshot.data!.docs
                  //  .where((doc) => doc['category'] == 'pearl')
                    .map((doc) => doc['producImage'] as String)
                    .toList();

                return ListView.builder(
                  itemCount: pearlImages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = pearlImages[index];
                    return DragTarget<Map<String, dynamic>>(
                      onAccept: (data) {
                        setState(() {
                          final left = _position?.dx ?? 0.0;
                          final top = _position?.dy ?? 0.0;
                          droppedImages.add(
                            Positioned(
                              left: left,
                              top: top,
                              child: Image.network(data['imageUrl'], width: 300, height: 300),
                            ),
                          );
                        });
                      },
                      builder: (context, accepted, rejected) {
                        return Draggable<Map<String, dynamic>>(
                          data: {
                            'imageUrl': imageUrl,
                          },
                          feedback: Image.network(
                            imageUrl,
                            width: 300,
                            height: 300,
                          ),
                          childWhenDragging: Image.network(
                            imageUrl,
                            width: 250,
                            height: 250,
                          ),
                          child: Builder(
                            builder: (context) {
                              return GestureDetector(
                                onPanUpdate: (details) {
                                  setState(() {
                                    _position = details.globalPosition;
                                  });
                                },
                                child: Image.network(
                                  imageUrl,
                                  width: 300,
                                  height: 300,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



































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

