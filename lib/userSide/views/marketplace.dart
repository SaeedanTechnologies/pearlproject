import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pearl/adminPanel/models/addpearlModel.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cataloge'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('productImages').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var pearl = UploadPearlModel.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);

                return GestureDetector(
                  onTap: () {
                    showImageDialog(
                        context,
                        pearl.pearlImage!,
                        pearl.pearlName!,
                        pearl.pearlPrice.toString(),
                        pearl.pearlDescription.toString(),
                        pearl.stock.toString());
                  },
                  child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(pearl.pearlImage!),
                    ),

                    title: pearl.pearlName.toString().text.bold.black.make(),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Price: \$ ${pearl.pearlPrice}".text.black.make(),
                        "Available Stock  ${pearl.stock}".text.black.make(),
                      ],
                    ),
                    //  Text(price)
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void showImageDialog(BuildContext context, String imageUrl, String name,
    String price, String description, String stock) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: name.text.black.make(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(
                imageUrl,
              ),
            ),
            const SizedBox(height: 16),
            name.text.black.make(),
            const SizedBox(height: 16),
            "Price: \$$price".text.black.make(),
            const SizedBox(height: 16),
            "Available Stock: $stock".text.black.make(),
            const SizedBox(height: 16),
            "About Pearl:".text.black.bold.make(),
            5.heightBox,
            description.text.black.align(TextAlign.center).makeCentered(),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
