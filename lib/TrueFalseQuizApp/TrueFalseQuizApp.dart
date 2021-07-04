import 'package:flutter/material.dart';

import '../AppTheme.dart';

class TrueFalseQuizApp extends StatefulWidget {
  @override
  _TrueFalseQuizAppState createState() => _TrueFalseQuizAppState();
}

class _TrueFalseQuizAppState extends State<TrueFalseQuizApp> {
  int index = 0;
  List<String> textList = [
    'It is a long established fact that a reader will be',
    ' distracted by the readable content of a page when looking at its layout. The poin',
    't of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using  m',
    't of using Lor as opposed to using  making it look like readable Eng',
    'ny web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (i',
    ' njected humour and the like).',
  ];
  List<bool> ansList = [
    true,
    true,
    true,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: Text(
          'Pakistan Quiz',
          style: TextStyle(color: Colors.green.shade800),
        ),
        shadowColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          InkWell(
            child: Ink(
              height: MediaQuery.of(context).size.width * 0.55,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 6,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/1280px-Flag_of_Pakistan.svg.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: green), borderRadius: BorderRadius.circular(20), color: white),
            child: Text(
              textList[index % textList.length],
              style: TextStyle(color: black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                    onPressed: () {
                      if (ansList[index] == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(duration: Duration(milliseconds: 100),backgroundColor: green, content: Text('Correct!')));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(duration: Duration(milliseconds: 100),backgroundColor: Colors.red, content: Text('InCorrect!')));
                      }
                    },
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.green),
                    )),
                Button(
                    onPressed: () {
                      if (ansList[index] == false) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(duration: Duration(milliseconds: 100),backgroundColor: green, content: Text('Correct!')));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(duration: Duration(milliseconds: 100),backgroundColor: Colors.red, content: Text('InCorrect!')));
                      }
                    },
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.green),
                    )),
                Button(
                    onPressed: () {
                      setState(() {
                        index = (index + 1) % ansList.length;
                      });
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const Button({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: green,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(10), color: white),
        child: child,
      ),
    );
  }
}
