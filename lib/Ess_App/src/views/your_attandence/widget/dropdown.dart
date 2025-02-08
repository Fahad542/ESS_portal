import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../styles/app_colors.dart';
Widget buildStatusDropdown(
    String? selectedStatus, // Updated parameter
    List<String> dropdownValues,
    void Function(String?) onChanged,
    ) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Container background color
      borderRadius: BorderRadius.all(Radius.circular(8)), // Border radius for rounded corners
      border: Border.all(
        color: AppColors.primary, // Set the border color to AppColors.primary
        width: 1, // Border width
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10), // Add some padding around the dropdown
    child: DropdownButton<String>(
      value: selectedStatus,
      onChanged: onChanged,
      items: dropdownValues.map((itemValue) {
        return DropdownMenuItem<String>(
          value: itemValue,
          child: Text(
            itemValue,
            style: TextStyle(
              color: itemValue == "Select Status" ? Colors.black : null,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      underline: Container(), // Remove the underline that is default in DropdownButton
    ),
  );
}
