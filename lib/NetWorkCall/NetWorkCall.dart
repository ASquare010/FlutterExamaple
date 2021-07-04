import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../AppTheme.dart';
import 'ModalClass.dart';

class NetWorkCalling extends StatefulWidget {
  @override
  _NetWorkCallingState createState() => _NetWorkCallingState();
}

class _NetWorkCallingState extends State<NetWorkCalling> {
  int count = 0;
  final url = 'https://jsonplaceholder.typicode.com/photos/';
  List<ModalClass> imageData = [];

  void snackBar() async {
    count++;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 3,
      duration: Duration(milliseconds: 300),
      content: Text('Image Added $count'),
    ));

    final res = await http.get(Uri.parse('$url$count'));
    setState(() {
      imageData.add(ModalClass.fromJson(map: json.decode(res.body)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        shadowColor: purple,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Text(
          "Total Images $count",
          style: TextStyle(color: purple),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        splashColor: white,
        backgroundColor: purple,
        onPressed: snackBar,
        label: Text(
          "Image",
          style: TextStyle(color: white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemBuilder: (builder, index) => ListViewCard(
            imageLink: imageData[index].url,
            price: imageData[index].id,
            title: imageData[index].title,
          ),
          itemCount: (imageData.length == null) ? 0 : imageData.length,
        ),
      ),
    );
  }
}

//  for receiving data form server in form of json

//            web/Api    url           ==>              json                  ==>             Map                ==>                                             ModalClass
//       "https://json.com/photos/"           get(Uri.parse('$url$count'))            json.decode(res.body)            Class Modal{ Modal(Map){ this.id = Map["id"] ; this.price = Map["price"] };int id ,price;}
