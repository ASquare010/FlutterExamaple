//http://api.openweathermap.org/data/2.5/forecast?q=lahore&cnt=7&units=metric&appid=d7ce83841d3908eb27a25017a80a0875link
//d7ce83841d3908eb27a25017a80a0875 key

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Utils {
  static String appKey = 'd7ce83841d3908eb27a25017a80a0875';

  static String getDateConverter(DateTime dateTime) {
    return DateFormat("EEE, MMM d, y").format(dateTime);
  }

  static IconData weatherIcon(String data) {
    if (data == 'Clouds') {
      return FontAwesomeIcons.cloud;
    } else if (data == 'Rain') {
      return FontAwesomeIcons.cloudRain;
    } else if (data == 'Clear') {
      return FontAwesomeIcons.sun;
    } else if (data == 'Snow') {
      return FontAwesomeIcons.snowman;
    } else {
      return Icons.arrow_drop_down_circle_outlined;
    }
  }
}
