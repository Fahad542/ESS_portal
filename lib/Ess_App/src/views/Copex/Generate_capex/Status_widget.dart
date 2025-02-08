import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class statuswidget extends StatefulWidget {
  String title;
  String value;
  Color color;
   statuswidget({

    Key? key,
     required this.title,
     required this.color,
     required this.value,

  });

  @override
  State<statuswidget> createState() => _statuswidgetState();
}

class _statuswidgetState extends State<statuswidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${widget.title}" , style: TextStyle( color: AppColors.black, fontSize: 13, fontWeight: FontWeight.bold)),

        Container(

          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              boxShadow: [

                BoxShadow(

                  color: Colors.grey.withOpacity(0.5), // Shadow color with opacity

                  spreadRadius: 2, // How much the shadow should spread

                  blurRadius: 5, // How blurred the shadow should be

                  offset: Offset(0, 3), // Offset of the shadow (horizontal, vertical)

                ),

              ],
          color: widget.color
          ),
          child: Row(
            children: [
              Text(widget.value, style: TextStyle(color: AppColors.white, fontSize: 12),),
            ],
          ),),
      ],
    );
  }
}
