import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/adminPanel/controllers/createOffersControllers.dart';
import 'package:pearl/adminPanel/models/offerModel.dart';
import 'package:pearl/const/alignments.dart';
import 'package:pearl/const/colors.dart';

class CreateOffers extends StatelessWidget {
  const CreateOffers({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOffersController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: maincenter,
          children: [
            TextField(
              style: TextStyle(color: blackColor),
              controller: controller.pointsController,
              decoration: const InputDecoration(labelText: 'Points'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              style: TextStyle(color: blackColor),
              controller: controller.offerController,
              decoration: const InputDecoration(labelText: 'Offers'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                controller.createOffer(OfferModel(
                    points: int.parse(controller.pointsController.text.trim()),
                    offer: controller.offerController.text.trim()));
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
