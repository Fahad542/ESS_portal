import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Ess_App/src/styles/app_colors.dart';
import 'Heading_text.dart';
import 'container.dart';

class EmployeeTable extends StatelessWidget {
  final VoidCallback? ontap;
   String? empcode;
   String? name;
   String? feedback;
  EmployeeTable({required this.ontap,  this.empcode,  this.name, this.feedback});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16), // Padding added
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align left
        children: [
          //HeadingText(title: "Emp Code", text: empcode.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadingText(title: "Name", text: name.toString()),
              if(feedback =="0")
              containerwidget(
                  title: 'Give your Feedback',
                  color: Colors.red,
                  Textcolor: Colors.white,
                  ontap: ontap
              ),
              if(feedback !="0")
                containerwidget(
                    title: 'Feedback Submitted!',
                    color: Colors.green,
                    Textcolor: Colors.white,

                ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              //HeadingText(title: 'Status', text: 'Pending'),


            ],
          ),
          // Add more text spans here...
        ],
      ),
    );
  }
}

class poll extends StatelessWidget {
  final VoidCallback? ontap;
  String? empcode;
  String? name;
  String? feedback;
  poll({required this.ontap,  this.empcode,  this.name, this.feedback});
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16), // Padding added
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align left
        children: [
         // HeadingText(title: "Emp Code", text: empcode.toString()),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 24, // Adjust height if needed
                width: 24, // Adjust width if needed
                child: Checkbox(
                  value: true,
                  onChanged: (value) {
                    // Handle checkbox state change
                  },
                ),
              ),
              SizedBox(width: 5,),
              HeadingText(title: "Name", text: name.toString()),
              if(feedback =="0")
                containerwidget(
                    title: 'Give your Feedback!',
                    color: Colors.red,
                    Textcolor: Colors.white,
                    ontap: ontap
                ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              //HeadingText(title: 'Status', text: 'Pending'),


            ],
          ),
          // Add more text spans here...
        ],
      ),
    );
  }
}
