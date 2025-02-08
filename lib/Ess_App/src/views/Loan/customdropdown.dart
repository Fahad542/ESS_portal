import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final void Function(String?) onChanged;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(
          color: AppColors.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [

            DropdownButton<String>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true, // Ensure the dropdown button expands to fit the container
            ),
          ],
        ),
      ),
    );
  }
}

