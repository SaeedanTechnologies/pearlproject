import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';


class CustomerApproval extends StatefulWidget {
  @override
  State<CustomerApproval> createState() => _CustomerApprovalState();
}

class _CustomerApprovalState extends State<CustomerApproval> {
//   Future validateAndSubmit(String customerId,String customerName,String id) async{

//      EasyLoading.show();
//      try{
//       var emailGenerated = await userController.emailNumberGenerated();
   
//    userController.update();
//    // await   userController.createUserWithEmailAndPassword(userController.referalEmail,userController.referalName,userController.customerIdss,userController.referalCity,userController.referalPhoneNumber,userController.referalDescription,userController.googleLocation,selectedOption,context);
// //  await   userController.createUserWithEmailAndPassword("${customerName}${emailGenerated}@solaris.com",customerName,customerId,context);
//    await   salesPersonController.notedFinance(id);
 

//            EasyLoading.dismiss();
//      }catch(e){
// EasyLoading.dismiss();

//      }
          
//      EasyLoading.dismiss();
   
//     // }
//   }
 
 
 final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
           decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/flower.jpg"),fit: BoxFit.cover)),
          child: Column(
            children: [
          SizedBox(height: halfHeight * 0.1),
              
                SizedBox(height: halfHeight * 0.1),
        
          StreamBuilder<QuerySnapshot>(
                 stream:  
                             FirebaseFirestore.instance
                                .collection('orders').
                                where("userid",isEqualTo:_firebaseAuth.currentUser!.uid)
                                
                                .snapshots(),
                 
                 builder: (context, snapshot) {
                   if (!snapshot.hasData) {
                     return CircularProgressIndicator();
                   }
              
                   final documents = snapshot.data!.docs;          
                   return
                   Container(
                    height: MediaQuery.of(context).size.height - 300,
                    width: MediaQuery.of(context).size.width,
                     child: 
                     ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                          var ids = documents[index].id;
                         var Name = documents[index]['name'];
                 
                    var Phone = documents[index]['phoneNumber'];
                                  var description = documents[index]["message"];
                                          var userId = documents[index]["userid"];
                                          var price = documents[index]["price"];
                                      
                                        
                                          var quotation = documents[index]["Qoutation"];
                                              var accessoryType = documents[index]["accessoryType"];
                                                var measure = documents[index]["measure"];
                                        
                                
                   return     Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                           decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.purple.withOpacity(0.2),
                     ),
                          child: Column(
                            children: [
               
                           
                           
                              ListTile(
                               
                                title: Text("Your Order ${accessoryType} with size {$measure} is placed successfully " ), 
                                // trailing: PickBy == "" ? Text("Add to List",style: TextStyle(color: Colors.green),) :  null,
                                subtitle:quotation ==  false ? Text("Waiting for Quotation" ) :Text("The price of this prodcut is ${price}"),
                              ),
                                          
                         
                                  quotation == false ?
                                  Text(""):
                                     ElevatedButton(
                          onPressed: () async{
                    // sendNotification();
                    // await alerts(customerId,cusName,ids);
                      
                 //   await    validateAndSubmit(customerId,cusName,ids);
            // await  salesPersonController.updateToken(ids,userController.userName!);
                  //  Get.to(()=>NotificationOpenedHandler()); 
                            print('Button Pressed!');
                          },
                          child: Text('Pay'),
                                          )
                                          
                                         
             
        
            //                                                            ElevatedButton(
            //                     onPressed: () async{
            //               // sendNotification();
            // await  salesPersonController.updateToken(ids,userController.userName!);
            //             //  Get.to(()=>NotificationOpenedHandler()); 
            //                       print('Button Pressed!');
            //                     },
            //                     child: Text('Add to Customer'),
            //                                     )
                                        
                                          
                                          
                            ] ,
                          ),
                        ),
                      );
                      }),
                   );
                
                 },
               ),
        
        
        
        
        
               
           
        
            ],
          ),
        ),
      ),
    );
  }
}
