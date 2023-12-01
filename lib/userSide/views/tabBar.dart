import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/controller/tabBarController.dart';

class TabBars extends StatefulWidget {
  const TabBars({Key? key}) : super(key: key);

  @override
  _TabBarsState createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> {
  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.put(TabBarController());
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter BottomNavigationBar Example'),
      //     backgroundColor: Colors.green
      // ),
      body: Obx(() => tabBarController.pages
          .elementAt(tabBarController.selectedIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HomeScreen",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "Orders",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
              backgroundColor: Colors.white,
            ),
          ],
          // type: BottomNavigationBarType.shifting,
          currentIndex: tabBarController.selectedIndex.value,
          selectedItemColor: blackColor,
          unselectedItemColor: Colors.grey,
          iconSize: 30.sp,
          onTap: (val) => tabBarController.selectedIndex.value = val,
        ),
      ),
    );
  }
}
