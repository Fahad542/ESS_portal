import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class containerwidget extends StatefulWidget {
  final String title ;
  final Color color;
  final Color Textcolor;
  final VoidCallback? ontap;
  const containerwidget({ required this.title, required this.color, this.ontap , required  this.Textcolor});


  @override
  State<containerwidget> createState() => _containerState();
}

class _containerState extends State<containerwidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(

          decoration: BoxDecoration(
            // gradient: LinearGradient(colors: [widget.color, Colors.black]),
              color: widget.color.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child:Padding(padding: EdgeInsets.all(8),
            child: Text(widget.title,
              style: TextStyle(color: widget.Textcolor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )),
    );
  }
}
