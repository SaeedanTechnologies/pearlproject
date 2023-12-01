import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pearl/adminPanel/models/offerModel.dart';
import 'package:pearl/utils/utils.dart';

class CreateOffersController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final pointsController = TextEditingController();
  final offerController = TextEditingController();
  createOffer(OfferModel offerModel) async {
    try {
      EasyLoading.show(status: "Offer creating");
      await firestore.collection("offers").doc().set(offerModel.toJson());
     
      EasyLoading.dismiss(animation: true);
    } catch (e) {
      Utils.fluttertoast(msg: e.toString());
      EasyLoading.dismiss(animation: true);
    }
  }
}
