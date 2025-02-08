import 'package:flutter/material.dart';

import '../../Ess_App/src/styles/app_colors.dart';

class HeadingText extends StatelessWidget {
  final String title;
  final String text;

  const HeadingText({required this.title, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return RichText(
    //   text: TextSpan(
    //     children: [
    //       TextSpan(
    //         text: '$title: ',
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.primary,
    //         ),
    //       ),
    //       TextSpan(
    //         text: text,
    //         style: TextStyle(color: Colors.black),
    //       ),
    //     ],
    //   ),
    // );
    return
    Row(children: [
   //   Text("${title}: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
      Text(text,style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),)
    ],);
  }
}
