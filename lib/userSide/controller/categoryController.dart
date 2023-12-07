import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoryController extends GetxController {
  var selectedGender = "Male".obs;
  var selectedCategory = "Necklace".obs;
  var selectSize = ''.obs;

  var categoryi = "Select Size".obs;
  var necklaceValue = "45cm".obs;
  var braceletValue = "15-16cm".obs;
  var ringValue = "48mm".obs;
  var bagJewelValue = "4cm".obs;
  var earringValue = "2mm".obs;

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
}
