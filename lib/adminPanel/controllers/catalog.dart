import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pearl/adminPanel/models/addpearlModel.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/widgets/customIconButton.dart';
import 'package:velocity_x/velocity_x.dart';

class Cataloge extends StatefulWidget {
  const Cataloge({super.key});

  @override
  State<Cataloge> createState() => _CatalogeState();
}

class _CatalogeState extends State<Cataloge> {
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
              key: UniqueKey(),
              restorationId: snapshot.data!.docs.length.toString(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var switchValue = (snapshot.data!.docs[index]['isDisable']);
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
                    trailing: CustomeIconButton(
                        icon: Icons.delete,
                        iconcolor: redColor,
                        iconsize: 25.sp,
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("productImages")
                              .doc(snapshot.data?.docs[index].id)
                              .delete()
                              .then((value) {
                            setState(() {});
                            Get.snackbar("Deleted",
                                "The product is successfully deleted!");
                          });
                        }),
                    title: Row(
                      children: [
                        pearl.pearlName.toString().text.bold.black.make(),
                        Transform.scale(
                          scale: 0.7, // Adjust the scale factor as needed
                          child: Switch.adaptive(
                            value: switchValue,
                            onChanged: (value) async {
                              switchValue = value;

                              await FirebaseFirestore.instance
                                  .collection("productImages")
                                  .doc(snapshot.data?.docs[index].id)
                                  .update({"isDisable": switchValue});
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
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
