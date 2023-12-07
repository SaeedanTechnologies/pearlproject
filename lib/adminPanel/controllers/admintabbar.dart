import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/adminPanel/controllers/catalog.dart';
import 'package:pearl/adminPanel/views/adminHome.dart';
import 'package:pearl/adminPanel/views/awaitingAdmin.dart';
import 'package:pearl/adminPanel/views/createOffers.dart';

class AdminTabBarController extends GetxController{
  var selectedIndex = 0.obs;
  final List<Widget> pages = [
    const AdminScreen(),
    AdminApproval(),
    // awaitingAdmin(),
    const CreateOffers(),
    const Cataloge()
  ];
}