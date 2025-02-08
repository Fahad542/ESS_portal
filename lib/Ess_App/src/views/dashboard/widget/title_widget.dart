import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard_view.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  String selectedTitle = "";
  final String title;
  final Color color;
  final VoidCallback? onTap;

   // Add this property

  TitleWidget({
    required this.title,
    required this.color,

    this.onTap,

     // Initialize the property
  });

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  //bool isTapped=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   isTapped=true;
        // });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [
          //   BoxShadow(
          //     color: widget.color.withOpacity(0.1),// Shadow color
          //     //spreadRadius:3 , // Spread radius
          //     blurRadius: 2,   // Blur radius
          //     offset: Offset(0, 0), // Shadow offset
          //   ),
          // ],
         // border: Border.all(color: widget.color, width: 1)
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.w400,
              fontSize: 13

          ),
        ),
      ),
    );
  }
}
