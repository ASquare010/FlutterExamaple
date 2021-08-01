import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/BoardApp/Services/DataBase.dart';

class BottomSheetBoard extends StatefulWidget {
  final String uid;

  const BottomSheetBoard({Key key, this.uid}) : super(key: key);

  @override
  _BottomSheetBoardState createState() => _BottomSheetBoardState();
}

class _BottomSheetBoardState extends State<BottomSheetBoard> {
  String imgLink, title, description;
  num val;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DataBase(uid: widget.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: grey,
                      title: Text('Update Content'),
                      actions: [
                        _updateButton(widget.uid, snapshot.data.title, snapshot.data.price, snapshot.data.imageLink,
                            snapshot.data.description)
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: title ?? snapshot.data.title,
                                prefixIcon: Icon(Icons.title),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  imgLink = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  helperText: 'eg http//image',
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: imgLink ?? snapshot.data.imageLink,
                                  prefixIcon: Icon(Icons.image_outlined),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  inactiveColor: Colors.grey[300],
                                  activeColor: grey,
                                  value: val?? snapshot.data.price.toDouble(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      val = newVal;
                                    });
                                  },
                                  min: 0,
                                  max: 100,
                                  divisions: 10,
                                  label: 'Cost $val',
                                ),
                              ),
                              Text('Cost '),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: TextField(
                              maxLines: 5,
                              onChanged: (c) {
                                setState(() {
                                  description = c;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: description ?? snapshot.data.description,
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _updateButton(String uid, String t, num p, String i, String d) {
    return IconButton(
        onPressed: () {
          DataBase(uid: uid).updateUserData(
              title: title ?? t, price: val ?? p, imageLink: imgLink ?? i, description: description ?? d);
        },
        icon: Icon(Icons.cloud_upload_outlined));
  }
}
