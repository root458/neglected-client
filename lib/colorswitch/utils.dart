import 'package:flutter/material.dart';

class Utils {
  static Color getColor(String ccolor) {
    switch (ccolor) {
      case 'red':
        return Colors.red;
      case 'white':
        return Colors.white;
      case 'black':
        return Colors.black;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }
}
