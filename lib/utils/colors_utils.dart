import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class ColorsUtils {
  static const List<MaterialColor> colors = <MaterialColor>[
    Colors.blue,
    Colors.cyan,
    Colors.lightBlue,
    Colors.teal,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
  ];

  static charts.Color getClientColor(List<charts.Color> colors, int index) {
    if (index < colors.length) return colors.elementAt(index);

    MaterialColor color = ColorsUtils.colors.elementAt(index);
    colors.add(charts.Color(r: color.red, g: color.green, b: color.blue));

    return colors.last;
  }

  static charts.Color getColor(MaterialColor color) {
    return charts.Color(r: color.red, g: color.green, b: color.blue);
  }

  static charts.Color getColor2(Color color) {
    return charts.Color(r: color.red, g: color.green, b: color.blue);
  }
}
