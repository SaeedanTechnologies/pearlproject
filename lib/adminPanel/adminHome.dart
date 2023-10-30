import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pearl/loginScreen.dart';

import '../controller/userController.dart';



class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}
// final picker = ImagePicker();

// Future<void> pickImageFromGallery() async {
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     // Upload the selected image to Firebase Storage
//    final  imageUrl = await uploadImageToStorage(File(pickedFile.path));

//     // Send a message with the image URL to Firestore
//     sendMessageWithImage(imageUrl);
//   }
 
// }


//  Future<String> uploadImageToStorage(File imageFile) async {
//   final FirebaseStorage storage = FirebaseStorage.instance;
//   final Reference ref = storage.ref().child('chat_images/${DateTime.now().toString()}');
//   final UploadTask uploadTask = ref.putFile(imageFile);
//   final TaskSnapshot taskSnapshot = await uploadTask;
//   final imageUrl = await taskSnapshot.ref.getDownloadURL();
//   return imageUrl;
// }
//   final CollectionReference _code = FirebaseFirestore.instance.collection('pearlImages');

// void sendMessageWithImage(String imageUrl) async{

//    _code.add({
  
//        'image_url': imageUrl,
      
//     });

// }




class _AdminScreenState extends State<AdminScreen> {

 final ImagePicker _picker = ImagePicker();
    var imageFile;
    void  selectImages()async {
    final XFile? images = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {

   _imageFile =  images!;

    });
    
    if (images !=null) {
        userController.imageFile = images.path == null ? "" :images.path;
    userController.update();
    }
  
  }
    Future<void>? _clear() {
    setState(() => _imageFile = null,

    );
  }
 
    XFile? _imageFile;
  UserController userController = Get.put(UserController());
  Future<void>? alerts(){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: new
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          
            SizedBox(height: 30,),
            GestureDetector(
              onTap:(){
                // _pickImage(ImageSource.gallery);
                selectImages();
                Navigator.pop(context);
                print("object");
              } ,
              child: Row(
                children: [
                   Icon(Icons.browse_gallery),
       
                            //                Container(
                            // height: 40,
                            // width: 70,
                            // decoration: BoxDecoration(
                            //     color: Colors.black,
                            //     image: DecorationImage(image: AssetImage("assets/3.png"),fit: BoxFit.cover)),),
                  SizedBox(width: 5),
                  Text('Choose from Gallery '),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: 
      AppBar(     
        
        automaticallyImplyLeading: false,
        
          actions: [
           ElevatedButton(
                onPressed: ()async {
                  await  _firebaseAuth.signOut().then((value) => Get.to(()=>LoginScreen()));
                  
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
                },
                child: Text('Logout'),
              ),
        
        ],),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/flower.jpg"))
        ),
        child: Column(children: [

          Center(child: GestureDetector(
                onTap: ()async{
          
                },
                 child: Container(height: 30,width: 30,child: IconButton(
                  onPressed: ()async {
                      await alerts();
                  }, 
                 icon: Icon(Icons.upload_file)),),
               ),),

           if (_imageFile != null) ...[
                            Image.file(
                              width:200,
                              height:200,
                              File(
                                
                                _imageFile!.path)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // ElevatedButton(
                                //   child: Icon(Icons.crop),
                                //   onPressed: _cropImage,
                                // ),
                                ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Color(0xFF9D0105),),
                                  child: Icon(Icons.refresh,),
                                  onPressed: _clear,
                                ),
                                                            ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Color(0xFF9D0105),),
                                  child: Icon(Icons.upload_file,),
                                  onPressed:()async{
                              await       userController.uploadFilesPassport(_imageFile,context);
                                  },
                                ),
            
          
          
                              ],
                            ),
            
                            // Uploader(file: _imageFile)
                          ],
      /////    ElevatedButton(onPressed: (){}, child: Text("Upload Image")),
          
      ],),),
    );
  }
}