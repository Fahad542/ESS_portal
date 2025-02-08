import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Ess_App/src/styles/app_colors.dart';

class roundbutton extends StatefulWidget {
  final String title;
  final bool loading;
  final VoidCallback onpress;

  const roundbutton({
    required this.title,
    this.loading = false,
    required this.onpress,
  });

  @override
  State<roundbutton> createState() => _roundbuttonState();
}

class _roundbuttonState extends State<roundbutton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary, // Start color
              Colors.blueAccent, // End color (change as needed)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        height: 50,
        width: 200,
        child: Center(
          child: widget.loading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
