import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;
  final List<TextInputFormatter>? formatter;
  final bool editable; // Add this line

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType,
    this.editable = true,
    this.formatter

    // Default value is true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.primary, // Change the border color here
          width: 1.0, // Change the border width here
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters: formatter,
        enabled: editable,

        // Set the enabled property
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w400),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
class message extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;
  final bool editable; // Add this line

  const message({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType,
    this.editable = true, // Default value is true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.primary, // Change the border color here
          width: 1.0, // Change the border width here
        ),
      ),
      child: Container(
        height: 100,
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          enabled: editable, // Set the enabled property
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
