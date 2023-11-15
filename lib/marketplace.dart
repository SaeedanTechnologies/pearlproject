import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ImageGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Grid'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('productImages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ImageGrid(images: snapshot.data!.docs);
        },
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  final List<QueryDocumentSnapshot> images;

  ImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl = images[index]['producImage'];
        final name = images[index]['description'];
        // final price = images[index]['price'];
        
        

        return GestureDetector(
          onTap: () {
            showImageDialog(context, imageUrl, name);
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(height: 8),
              Expanded(child: Text(name)),
            //  Text(price)
            ],
          ),
        );
      },
    );
  }

  void showImageDialog(BuildContext context, String imageUrl, String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(height: 16),
              Text(name),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
