import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCoupon extends StatelessWidget {
   AddCoupon({super.key});
 final couponController = TextEditingController();
  final couponPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Enter discount coupon"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: couponController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Coupon Name"),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Price"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: couponPriceController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "\$"),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("Discount Codes")
                    .doc()
                    .set({
                  "Discount Name": couponController.text.toString(),
                  "Price": couponPriceController.text.toString()
                });
              },
              child: const Text(
                "Add coupon",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
