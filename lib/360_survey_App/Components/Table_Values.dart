import 'package:flutter/material.dart';

class TableValues extends StatelessWidget {
  final String title;
  final String sa;
  final String sd;
  final String d;
  final String a;
  final FontWeight titleFontWeight;
  final Color titleColor;
  final FontWeight saFontWeight;
  final Color saColor;
  final FontWeight sdFontWeight;
  final Color sdColor;
  final FontWeight dFontWeight;
  final Color dColor;
  final FontWeight aFontWeight;
  final Color aColor;

  TableValues({
    required this.title,
    required this.sa,
    required this.sd,
    required this.d,
    required this.a,
    this.titleFontWeight = FontWeight.normal,
    this.titleColor = Colors.black,
    this.saFontWeight = FontWeight.normal,
    this.saColor = Colors.black,
    this.sdFontWeight = FontWeight.normal,
    this.sdColor = Colors.black,
    this.dFontWeight = FontWeight.normal,
    this.dColor = Colors.black,
    this.aFontWeight = FontWeight.normal,
    this.aColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(fontWeight: titleFontWeight, color: titleColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              sa,
              style: TextStyle(fontWeight: saFontWeight, color: saColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              sd,
              style: TextStyle(fontWeight: sdFontWeight, color: sdColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              d,
              style: TextStyle(fontWeight: dFontWeight, color: dColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              a,
              style: TextStyle(fontWeight: aFontWeight, color: aColor),
            ),
          ),
        ],
      ),
    );
  }
}


class DynamicDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry padding;

  DynamicDivider({
    this.color = Colors.grey,
    this.thickness = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(
        color: color,
        thickness: thickness,
      ),
    );
  }
}
