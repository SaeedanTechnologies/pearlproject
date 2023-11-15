import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/const/const.dart';
import 'package:pearl/controller/controllerRef.dart';
import 'package:pearl/pealSelect.dart';

class NextScreen extends StatefulWidget {
  String? genderss;
  String? category;
  NextScreen({this.genderss,this.category});
  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  // final List<String> dropdownItems = [
  // "asdasd",
    
  // ];
  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
}
  List<DropdownMenuItem<String>> get bracelet{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("15-16cm"),value: "15-16cm"),
    DropdownMenuItem(child: Text("16-17cm"),value: "16-17cm"),
    DropdownMenuItem(child: Text("17-18cm"),value: "17-18cm"),
    DropdownMenuItem(child: Text("18-19cm"),value: "18-19cm"),
    DropdownMenuItem(child: Text("19-20cm"),value: "19-20cm"),
    DropdownMenuItem(child: Text("20-21cm"),value: "20-21cm"),
  ];
  return menuItems;
}

  List<DropdownMenuItem<String>> get necklace{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("45cm"),value: "45cm"),
    DropdownMenuItem(child: Text("50cm"),value: "50cm"),
    DropdownMenuItem(child: Text("55cm"),value: "55cm"),
    DropdownMenuItem(child: Text("60cm"),value: "60cm"),

  ];
  return menuItems;
}


 List<DropdownMenuItem<String>> get bagJewels{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("4cm"),value: "4cm"),
    DropdownMenuItem(child: Text("5cm"),value: "5cm"),
    DropdownMenuItem(child: Text("6cm"),value: "6cm"),
    DropdownMenuItem(child: Text("7cm"),value: "7cm"),
    DropdownMenuItem(child: Text("8cm"),value: "8cm"),

  ];
  return menuItems;
}


 List<DropdownMenuItem<String>> get earringss{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("2mm"),value: "2mm"),
    DropdownMenuItem(child: Text("3mm"),value: "3mm"),
    DropdownMenuItem(child: Text("4mm"),value: "4mm"),
    DropdownMenuItem(child: Text("5mm"),value: "5mm"),

     DropdownMenuItem(child: Text("6mm"),value: "6mm"),
      DropdownMenuItem(child: Text("7mm"),value: "7mm"),
      

  ];
  return menuItems;
}





  List<DropdownMenuItem<String>> get ring{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("48mm"),value: "48mm"),
    DropdownMenuItem(child: Text("49mm"),value: "49mm"),
    DropdownMenuItem(child: Text("50mm"),value: "50mm"),
    DropdownMenuItem(child: Text("51mm"),value: "51mm"),

     DropdownMenuItem(child: Text("52mm"),value: "52mm"),
      DropdownMenuItem(child: Text("53mm"),value: "53mm"),
       DropdownMenuItem(child: Text("54mm"),value: "54mm"),
        DropdownMenuItem(child: Text("55mm"),value: "55mm"),
         DropdownMenuItem(child: Text("56mm"),value: "56mm"),

           DropdownMenuItem(child: Text("57mm"),value: "57mm"),
      DropdownMenuItem(child: Text("58mm"),value: "58mm"),
       DropdownMenuItem(child: Text("59mm"),value: "59mm"),
        DropdownMenuItem(child: Text("60mm"),value: "60mm"),
         DropdownMenuItem(child: Text("61mm"),value: "61mm"),
            DropdownMenuItem(child: Text("62mm"),value: "62mm"),
       DropdownMenuItem(child: Text("63mm"),value: "63mm"),
        DropdownMenuItem(child: Text("64mm"),value: "64mm"),
         DropdownMenuItem(child: Text("65mm"),value: "65mm"),

  ];
  return menuItems;
}
//   List<DropdownMenuItem<String>> get necklace{
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(child: Text("45cm"),value: "45cm"),
//     DropdownMenuItem(child: Text("50cm"),value: "50cm"),
//     DropdownMenuItem(child: Text("55cm"),value: "55cm"),
//     DropdownMenuItem(child: Text("60cm"),value: "60cm"),

//   ];
//   return menuItems;
// }

String categoryi = "Select Size";
String necklaceValue = "45cm";
String braceletValue = "15-16cm";
String ringValue = "48mm";
String bagJewelValue =  "4cm";
String earringValue="2mm";
 // Use GetX for global state management
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child:
        Container(
             decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/flower.jpg"),fit: BoxFit.cover)
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

    widget.category == "necklace" ?
               Image.asset(
                'assets/images/necklace.png', // Replace with your image path
                width: 300,
                height: 300,
              )
              : widget.category == "bracelet" ?
               Image.asset(
                'assets/images/bracelet.jpg', // Replace with your image path
                width: 300,
                height: 300,
              )
              :
              widget.category == "ring" ?
                Image.asset(
                'assets/images/ring.jpg', // Replace with your image path
                width: 300,
                height: 300,
              )
              :
              Container()
              ,
                  SizedBox(height: 20),
               Text(
                'Please Select Size',
                style: TextStyle(fontStyle: FontStyle.italic,color: purpleColor),
              ),
              // Image.asset(
              //   'assets/images/arrow-slider.png', // Replace with your image path
              //   width: 100,
              //   height: 100,
              // ),
              SizedBox(height: 20),
  widget.category == "necklace" ? 
    DropdownButton(
      value: necklaceValue,
      onChanged: (String? newValue){
        setState(() {
        necklaceValue = newValue!;
        });
      },
      items: necklace
      )
      :
 widget.category == "bracelet" ?   DropdownButton(
      value: braceletValue,
      onChanged: (String? newValue){
        setState(() {
        braceletValue = newValue!;
        });
      },
      items: bracelet
      )
      :
       widget.category == "ring" ?   DropdownButton(
      value: ringValue,
      onChanged: (String? newValue){
        setState(() {
          ringValue = newValue!;
        });
      },
      items: ring
      )
:
 widget.category == "bagJewel" ?   DropdownButton(
      value: bagJewelValue,
      onChanged: (String? newValue){
        setState(() {
          bagJewelValue = newValue!;
        });
      },
      items: bagJewels
      )
      :

 widget.category == "earrings" ?   DropdownButton(
      value: earringValue,
      onChanged: (String? newValue){
        setState(() {
         earringValue = newValue!;
        });
      },
      items: earringss
      )
      :
      Container()
  ,
              SizedBox(height: 20),
              Text(
                'Select size',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Confirm'),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>ImagePickerScreen(gender:widget.genderss,category:widget.category,size:widget.category == "necklace"?
                      necklaceValue:widget.category == "bracelet"?braceletValue :widget.category == "ring"?ringValue:widget.category == "bagJewel"?bagJewelValue:widget.category == "earrings"?earringValue:"none"
                      
                      
                      ));
                    },
                    child: Image.asset(
                      'assets/images/arrow-slider.png', // Replace with your image path
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

