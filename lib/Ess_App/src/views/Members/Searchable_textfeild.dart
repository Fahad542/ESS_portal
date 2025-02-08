import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class CustomTextFields extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomTextFields({
    Key? key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppColors.primary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.primary),
        prefixIcon: Icon(Icons.search, color: AppColors.primary,),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:AppColors.primary ),
            borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(16)
        ),
        border: OutlineInputBorder(


          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
