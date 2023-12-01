import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pearl/const/colors.dart';
import 'package:pearl/userSide/controller/controllerRef.dart';
import 'package:pearl/userSide/views/pealSelect.dart';

class NextScreen extends StatefulWidget {
  String? genderss;
  String? category;
  NextScreen({this.genderss, this.category});
  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  // final List<String> dropdownItems = [
  // "asdasd",

  // ];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USA", child: Text("USA")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get bracelet {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "15-16cm", child: Text("15-16cm")),
      const DropdownMenuItem(value: "16-17cm", child: Text("16-17cm")),
      const DropdownMenuItem(value: "17-18cm", child: Text("17-18cm")),
      const DropdownMenuItem(value: "18-19cm", child: Text("18-19cm")),
      const DropdownMenuItem(value: "19-20cm", child: Text("19-20cm")),
      const DropdownMenuItem(value: "20-21cm", child: Text("20-21cm")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get necklace {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "45cm", child: Text("45cm")),
      const DropdownMenuItem(value: "50cm", child: Text("50cm")),
      const DropdownMenuItem(value: "55cm", child: Text("55cm")),
      const DropdownMenuItem(value: "60cm", child: Text("60cm")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get bagJewels {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "4cm", child: Text("4cm")),
      const DropdownMenuItem(value: "5cm", child: Text("5cm")),
      const DropdownMenuItem(value: "6cm", child: Text("6cm")),
      const DropdownMenuItem(value: "7cm", child: Text("7cm")),
      const DropdownMenuItem(value: "8cm", child: Text("8cm")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get earringss {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "2mm", child: Text("2mm")),
      const DropdownMenuItem(value: "3mm", child: Text("3mm")),
      const DropdownMenuItem(value: "4mm", child: Text("4mm")),
      const DropdownMenuItem(value: "5mm", child: Text("5mm")),
      const DropdownMenuItem(value: "6mm", child: Text("6mm")),
      const DropdownMenuItem(value: "7mm", child: Text("7mm")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get ring {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "48mm", child: Text("48mm")),
      const DropdownMenuItem(value: "49mm", child: Text("49mm")),
      const DropdownMenuItem(value: "50mm", child: Text("50mm")),
      const DropdownMenuItem(value: "51mm", child: Text("51mm")),
      const DropdownMenuItem(value: "52mm", child: Text("52mm")),
      const DropdownMenuItem(value: "53mm", child: Text("53mm")),
      const DropdownMenuItem(value: "54mm", child: Text("54mm")),
      const DropdownMenuItem(value: "55mm", child: Text("55mm")),
      const DropdownMenuItem(value: "56mm", child: Text("56mm")),
      const DropdownMenuItem(value: "57mm", child: Text("57mm")),
      const DropdownMenuItem(value: "58mm", child: Text("58mm")),
      const DropdownMenuItem(value: "59mm", child: Text("59mm")),
      const DropdownMenuItem(value: "60mm", child: Text("60mm")),
      const DropdownMenuItem(value: "61mm", child: Text("61mm")),
      const DropdownMenuItem(value: "62mm", child: Text("62mm")),
      const DropdownMenuItem(value: "63mm", child: Text("63mm")),
      const DropdownMenuItem(value: "64mm", child: Text("64mm")),
      const DropdownMenuItem(value: "65mm", child: Text("65mm")),
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
  String bagJewelValue = "4cm";
  String earringValue = "2mm";
  // Use GetX for global state management
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/flower.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.category == "necklace"
                  ? Image.asset(
                      'assets/images/necklace.png', // Replace with your image path
                      width: 300,
                      height: 300,
                    )
                  : widget.category == "bracelet"
                      ? Image.asset(
                          'assets/images/bracelet.jpg', // Replace with your image path
                          width: 300,
                          height: 300,
                        )
                      : widget.category == "ring"
                          ? Image.asset(
                              'assets/images/ring.jpg', // Replace with your image path
                              width: 300,
                              height: 300,
                            )
                          : Container(),
              const SizedBox(height: 20),
              Text(
                'Please Select Size',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: purpleColor),
              ),
              // Image.asset(
              //   'assets/images/arrow-slider.png', // Replace with your image path
              //   width: 100,
              //   height: 100,
              // ),
              const SizedBox(height: 20),
              widget.category == "necklace"
                  ? DropdownButton(
                      value: necklaceValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          necklaceValue = newValue!;
                        });
                      },
                      items: necklace)
                  : widget.category == "bracelet"
                      ? DropdownButton(
                          value: braceletValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              braceletValue = newValue!;
                            });
                          },
                          items: bracelet)
                      : widget.category == "ring"
                          ? DropdownButton(
                              value: ringValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  ringValue = newValue!;
                                });
                              },
                              items: ring)
                          : widget.category == "bagJewel"
                              ? DropdownButton(
                                  value: bagJewelValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      bagJewelValue = newValue!;
                                    });
                                  },
                                  items: bagJewels)
                              : widget.category == "earrings"
                                  ? DropdownButton(
                                      value: earringValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          earringValue = newValue!;
                                        });
                                      },
                                      items: earringss)
                                  : Container(),
              const SizedBox(height: 20),
              const Text(
                'Select size',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Confirm'),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ImagePickerScreen(
                          gender: widget.genderss,
                          category: widget.category,
                          size: widget.category == "necklace"
                              ? necklaceValue
                              : widget.category == "bracelet"
                                  ? braceletValue
                                  : widget.category == "ring"
                                      ? ringValue
                                      : widget.category == "bagJewel"
                                          ? bagJewelValue
                                          : widget.category == "earrings"
                                              ? earringValue
                                              : "none"));
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
