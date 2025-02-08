import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0), // Border radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none, // Remove the default border
          hintText: 'Search', // Hint text
          hintStyle: TextStyle(color: AppColors.primary), // Hint text color
          prefixIcon: Icon(
            Icons.search, // Search icon
              color: AppColors.primary
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), // Padding inside the TextField
        ),
      ),
    );
  }
}
