import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/adminPanel/controllers/admintabbar.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminTabBarController());
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter BottomNavigationBar Example'),
      //     backgroundColor: Colors.green
      // ),
      body:
          Obx(() => controller.pages.elementAt(controller.selectedIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            selectedLabelStyle: const TextStyle(color: Colors.black),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.link),
                label: "Admin",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.comment),
                label: "Orders",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Create Offer",
                backgroundColor: Colors.white,
              ),
            ],
            // type: BottomNavigationBarType.shifting,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            iconSize: 40,
            onTap: (val) {
              controller.selectedIndex.value = val;
            },
            elevation: 5),
      ),
    );
  }
}
