import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/userSide/views/awaiting.dart';
import 'package:pearl/userSide/views/homeScreen.dart';
import 'package:pearl/userSide/views/profiled.dart';

class TabBarController extends GetxController{
  var selectedIndex = 0.obs;
  final List<Widget> pages = <Widget>[
    HomeScreen(),
    CustomerApproval(),
    const ProfileScreen()
  ];
}