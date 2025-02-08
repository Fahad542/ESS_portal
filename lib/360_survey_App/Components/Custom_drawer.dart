import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Ess_App/src/services/local/navigation_service.dart';
import '../Api_services/data/Local_services/Session.dart';
import '../Screens/Check_pool/check_poll_view.dart';
import '../Screens/Dashboard/Dashboard_view.dart';
import '../Screens/Feedback/Feedback_view.dart';
import '../Screens/See_Your_Result/result_view.dart';

class CustomDrawer extends StatelessWidget {
  Sharedprefrence sp=Sharedprefrence();
  @override

  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)), // Border radius add kiya
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)), // ClipRRect ke sath border radius
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo image

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/personn.png'), // Image ka path
                          radius: 40, // Avatar ka radius
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    // Bold text for user name
                    Expanded(
                      child: Text(
                        "${UserData.username.toString()}(${UserData.empCode})", // Yahan user ka naam likhein
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary, // Start color
                      AppColors.primary, // End color (change as needed)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: AppColors.primary),
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                 // NavService.survey_dashboard();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => DashboardScreen()),
                  //       (Route<dynamic> route) => false,
                  // );
                 // Navigator.push(context , MaterialPageRoute(builder: (context)=> DashboardScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.poll, color: AppColors.primary),
                title: Text('Check Your Pool'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => check_poll()),

                  );
                  //Navigator.pop(context);
                  //NavService.survey_poll();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => check_poll()),
                  //       (Route<dynamic> route) => false,
                  // );
                 // Navigator.pop(context);
                 // Navigator.push(context , MaterialPageRoute(builder: (context)=> check_poll()));
                   },
              ),
              ListTile(
                leading: Icon(Icons.access_alarm, color: AppColors.primary),
                title: Text('See Your Result'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Result()),

                  );
                 // Navigator.push(context , MaterialPageRoute(builder: (context)=> Result()));

                  // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback, color: AppColors.primary),
                title: Text('Give Your Feedback'),
                onTap: () {
                  Navigator.pop(context);
                 // Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Feedbacks()),

                  );
                  //Navigator.push(context , MaterialPageRoute(builder: (context)=> Feedbacks()));
                   // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.menu, color: AppColors.primary),
                title: Text('All Apps'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.pop(context);
                 NavService.appmenu();
                  //Navigator.push(context , MaterialPageRoute(builder: (context)=> Feedbacks()));
                  // Close the drawer
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
