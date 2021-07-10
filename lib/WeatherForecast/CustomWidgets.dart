import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double margin, padding, borderRadius;

  const BlurContainer({this.margin = 8, this.padding = 8, this.borderRadius = 8, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFE9F3F9).withOpacity(0.2),
                      Color(0xFFE1ECFF).withOpacity(0.1)
                    ],
                    end: Alignment.topRight)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class DayWeatherChip extends StatelessWidget {
  final String day, temp;
  final IconData icon;

  const DayWeatherChip({this.temp = '10', this.day = 'Sunday',this.icon = FontAwesomeIcons.sun});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(10),
          left: Radius.circular(10),
        ),
        color: white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      // spreadRadius: 5,
                      blurRadius: 6,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    // left: Radius.circular(10),
                  ),
                  color: white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day,
                  ),
                  Text('$temp °C'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(icon,color: Colors.black.withOpacity(0.6),),
          )
        ],
      ),
    );
  }
}

class WeatherInfoContainer extends StatelessWidget {
  final String text;
  final IconData icon;

  const WeatherInfoContainer({this.text = 'temp', this.icon = Icons.http});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: Text(
            text,
            style: TextStyle(color: grey),
          ),
        ),
        Icon(
          icon,
          color: white,
        ),
      ],
    );
  }
}
