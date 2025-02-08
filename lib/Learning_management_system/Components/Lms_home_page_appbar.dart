import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/views/Loan/customtextfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../360_survey_App/Api_services/data/Local_services/Session.dart';
import '../../Ess_App/src/services/local/navigation_service.dart';
import '../../Ess_App/src/styles/app_colors.dart';
import '../Screens/Lms_Dashboard/Search_controller.dart';

class Lms_homapge_bar extends StatelessWidget {
  final String title;
  AdvancedDrawerController adcontroller;
  bool islogout;
  final BuildContext context; // Fixed: Removed 'final' from context to avoid compile error.
 // final VoidCallback onMenuTap;

  Lms_homapge_bar({
    required this.title,
    this.islogout = true,
    required this.context,
    required this.adcontroller,
    //required this.onMenuTap,
  });
TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
            height: 137,
            padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(45.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                offset: Offset(0, 4), // Position of the shadow
                blurRadius: 6, // Blur effect
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             InkWell(
               onTap:(){_handleMenuButtonPressed(adcontroller);},
               child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
               Icon(
                  Icons.menu,
                  //size: 25,
                  color: AppColors.primary,
                ),
               // onPressed: onMenuTap,
              ),),),
              SizedBox(width: 10,),
              Expanded( // Use Expanded to allow the title to take available space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 50,),
                        Expanded(

                          child: Text(
                            title,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ), // Title text style
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Let's Start Learning",
                      style: TextStyle(color: Colors.white),
                    ),
                    // SizedBox(height: 20,),
                    // SearchField(),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              if (!islogout) // Check if not logged out before showing the button
               InkWell(
                 onTap: (){
                     showDialog(
                       context: context,
                       builder: (context) => AlertDialog(
                         title: Text(
                           'Logout',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                           ),
                         ),
                         content: Text(
                           'Are you sure you want to logout?',
                           style: TextStyle(
                             fontSize: 16,
                             color: Colors.white,
                           ),
                         ),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         backgroundColor: AppColors.primary,
                         actions: [
                           TextButton(
                             onPressed: () {
                               Navigator.of(context).pop(); // Close dialog
                             },
                             child: Text(
                               'Cancel',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                           TextButton(
                             onPressed: () async {
                               print("Logging out...");
                               SharedPreferences sp = await SharedPreferences.getInstance();
                               //await sp.clear();
                               sp.remove("lms Login data");
                               lmsUserData.lmsclearUserData();
                              // LmsUserData.clearUserData();
                               Navigator.of(context).pop(); // Close dialog
                               NavService.appmenu(); // Navigate to app menu
                             },
                             child: Text(
                               'Logout',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         ],
                       ),
                     );
                 },
                 child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.logout, color: Colors.white), // Logout icon

                    ),
                  ),

              // Placeholder for alignment if needed
               ) ],
    )
        ),
        SizedBox(height: 13),
        // Additional widgets can be added here if needed
      ],
    );
  }
  void _handleMenuButtonPressed(AdvancedDrawerController controller) {
    controller.showDrawer();
  }
}





class general_bar extends StatelessWidget {
  final String title;
  AdvancedDrawerController adcontroller;

  final BuildContext context; // Fixed: Removed 'final' from context to avoid compile error.
  // final VoidCallback onMenuTap;

  general_bar({
    required this.title,

    required this.context,
    required this.adcontroller,
    //required this.onMenuTap,
  });
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(

            padding: const EdgeInsets.all(8), // Add some padding
            decoration: BoxDecoration(
              //color: AppColors.primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(45.0)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2), // Shadow color
              //     offset: Offset(0, 4), // Position of the shadow
              //     blurRadius: 6, // Blur effect
              //     spreadRadius: 0,
              //   ),
              // ],
            ),
            child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
             // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:(){_handleMenuButtonPressed(adcontroller);},
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                        Icon(
                          Icons.menu,
                          //size: 25,
                          color: AppColors.primary,
                        ),
                        // onPressed: onMenuTap,
                      ),),),
                ),
                 Text(
                    title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ), // Title text style
                  ),
Text('')
               // SizedBox(width: 10,),

                ],
            )
        ),
        SizedBox(height: 13),
        // Additional widgets can be added here if needed
      ],
    );
  }
  void _handleMenuButtonPressed(AdvancedDrawerController controller) {
    controller.showDrawer();
  }
}
