

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pearl/adminPanel/adminHome.dart';
import 'package:pearl/adminPanel/awaitingAdmin.dart';
import 'package:pearl/homeScreen.dart';



  
  
class AdminHome extends StatefulWidget {  
  AdminHome ({Key? key}) : super(key: key);  
  
  @override  
  _AdminHomeState createState() => _AdminHomeState();  
}  
  
class _AdminHomeState extends State<AdminHome > {  


  int _selectedIndex = 0;  
   List<Widget> _widgetOptions = <Widget>[  

   AdminScreen(),
    AdminApproval(),
 // awaitingAdmin(),

  ];  
int tt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      // appBar: AppBar(  
      //   title: const Text('Flutter BottomNavigationBar Example'),  
      //     backgroundColor: Colors.green  
      // ),  
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.link),  
            label: "Admin",  
            backgroundColor: Colors.white  ,
           
           

          ),  
          
          BottomNavigationBarItem(  
            icon: Icon(Icons.comment),  
         label: 
         
         "Orders",  
            backgroundColor: Colors.white, 
          ),  
         
        ],  
        // type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        unselectedItemColor: Colors.grey,
        
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  
    );  
  }  
}  
