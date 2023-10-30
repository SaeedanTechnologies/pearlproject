import 'package:flutter/material.dart';


class QuoteScreen extends StatefulWidget {

      String? gender;

  String? category;

  String? size;

  QuoteScreen({required this.category,required this.gender,required this.size});
  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request a Quote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
                         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/flower.jpg"),fit: BoxFit.cover)
        ),
            child: Column(
              children: <Widget>[
                Text('Name'),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Phone Number'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Email'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Gender'),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.gender,
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Accessory Type'),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.category,
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Measure'),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.size,
                    border: OutlineInputBorder(),
                  ),
                ),
                Text('Model Screen Shot'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle image upload
                    },
                    child: Text('Upload Image'),
                  ),
                ),
                Text('Message'),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle quote submission
                    },
                
             
                    child: Text('Ask for Quote'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
