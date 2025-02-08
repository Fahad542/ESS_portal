import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class Custom_App_Bar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback onNotificationPressed;


  const Custom_App_Bar({
    Key? key,
    required this.title,
    required this.onBackPressed,
    required this.onNotificationPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onBackPressed,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 25),
            ),
            InkWell(
              onTap: onNotificationPressed,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.notifications, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
