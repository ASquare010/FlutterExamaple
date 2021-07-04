import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';

class TipCalculate extends StatefulWidget {
  @override
  _TipCalculateState createState() => _TipCalculateState();
}

class _TipCalculateState extends State<TipCalculate> {
  double valSlider = 0, totalBill = 0.0;
  int split = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 0),
            height: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: blue.withOpacity(0.1)),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Total per person',
                      style: TextStyle(
                        color: blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '\$${(totalBill / split).toStringAsFixed(2)}',
                      style: TextStyle(color: blue, fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), border: Border.all(width: 1.5, color: lightGrey)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: blue),
                    onChanged: (String val) {
                      try {
                        setState(() {
                          totalBill = double.parse(val);
                        });
                      } catch (e) {
                        totalBill = 0.0;
                      }
                    },
                    cursorColor: blue,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Bill Amount',
                        prefixIcon: Icon(Icons.attach_money,color: blue,),
                        labelStyle: TextStyle(color: blue.withOpacity(0.5)),
                        isDense: true,
                        border: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: lightGrey)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: blue))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text('Split Bill')),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button(
                              onTap: () {
                                setState(() {
                                  if (split > 1) {
                                    split--;
                                  }
                                });
                              },
                              icon: Icons.remove,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '$split',
                                style: TextStyle(color: blue),
                              ),
                            ),
                            Button(
                              onTap: () {
                                setState(() {
                                  split++;
                                });
                              },
                              icon: Icons.add,
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip'),
                      Text(
                        '\$${((totalBill/100)*valSlider).toStringAsFixed(2)}',
                        style: TextStyle(color: blue, fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    '$valSlider %',
                    style: TextStyle(color: blue, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: blue,
                    inactiveColor: blue.withOpacity(0.1),
                    label: '% $valSlider',
                    value: valSlider,
                    onChanged: (c) {
                      setState(() {
                        valSlider = c;
                      });
                    },
                    max: 100,
                    min: 0,
                    divisions: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  const Button({Key key, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: blue,
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(
          icon,
          color: blue,
        ),
      ),
    );
  }
}
