import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../controller/controllerRef.dart';


class AdminApproval extends StatefulWidget {
  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
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
TextEditingController nameController = TextEditingController();

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
                                .collection('orders')
                               .where("Qoutation",isEqualTo: false)
                                
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
                                      
                                        var modelScreenshot = documents[index]["modelScreenshot"];
                                          var quotation = documents[index]["Qoutation"];
                                              var accessoryType = documents[index]["accessoryType"];
                                                var measure = documents[index]["measure"];
                                                var docId = documents[index]["docId"];
                                        final textController = TextEditingController();
                                
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
                               
                                title: Text("Your Order ${accessoryType} with size {$measure} is received" ), 
                                // trailing: PickBy == "" ? Text("Add to List",style: TextStyle(color: Colors.green),) :  null,
                                subtitle:
                                   TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "write your Qoutation"
                  ),
                ),
               
                                //quotation ==  false ? Text("Waiting for Quotation" ) :Text("The price of this prodcut is ${price}"),
trailing: GestureDetector(
onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ImageDialog(imageUrl:modelScreenshot);
            },
          );
        },  
  child:   Container(
  
    height: 100,
  
    width: 50,
    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(modelScreenshot),fit: BoxFit.cover)),
  
   
    
    ),
),
                              ),
                                          
                         
                            
                                     ElevatedButton(
                          onPressed: () async{
                    // sendNotification();
                    // await alerts(customerId,cusName,ids);
                      
                   await    userController.sendQuotation(textController.text,ids);
            // await  salesPersonController.updateToken(ids,userController.userName!);
                  //  Get.to(()=>NotificationOpenedHandler()); 
                            print('Button Pressed!');
                          },
                          child: Text('Send Quotation'),
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
class ImageDialog extends StatelessWidget {
  final String imageUrl;

  ImageDialog({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(imageUrl), // Display the image
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}