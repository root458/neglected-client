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

class ColorSwitchValues {
  ColorSwitchValues({
    required this.baseDomain,
    required this.clientUniqueID,
  });

  final String baseDomain;
  final String clientUniqueID;
}

class ColorSwitchConfig {
  factory ColorSwitchConfig({required ColorSwitchValues values}) {
    return _instance ??= ColorSwitchConfig._internal(values);
  }

  ColorSwitchConfig._internal(this.values);

  final ColorSwitchValues values;
  static ColorSwitchConfig? _instance;

  static ColorSwitchConfig? get instance => _instance;
}
