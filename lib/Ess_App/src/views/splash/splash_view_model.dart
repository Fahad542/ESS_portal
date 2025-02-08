import 'package:ess/App_menu.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../360_survey_App/Api_services/data/Local_services/Session.dart';


class SplashViewModel extends ReactiveViewModel with AuthViewModel {
  Sharedprefrence sp =Sharedprefrence();
  init(BuildContext context) async {
   // Dialogbox(context);
    await sp.getdata();
    firstRouter(context);

    print("object");
  }

  void Dialogbox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Background Location Permission',
              style: TextStyle(fontWeight: FontWeight.bold), // Optional: Bold text
            ),
          ),
          content: Text(
            'We use your background location to mark your check-in when you arrive at the premises. '
                'Your data is secure and used solely for this purpose.',
          ),
          actions: <Widget>
          [
            TextButton(
              child: Text('OK'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void firstRouter(context) async {
    NavService.appmenu();
    // if (authService.user?.email == null && UserData.username == null)
    //   Future.delayed(Duration(milliseconds: 5), () {
    //     // Login Page Route
    //     print("Login Page Route");
    //     authService.user = null;
    //     //NavService.appmenu();
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => AppMenu()),
    //     );
    //     print(authService.user?.email);
    //     print(authService.user?.AdvFinApp);
    //   });
    // else if(authService.user?.email == null && UserData.username!.isNotEmpty)
    // {
    //
    //   Future.delayed(Duration(milliseconds: 5), () {
    //
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
    //   });
    // }
    // else if(authService.user?.email != null && UserData.username==null)
    //   {
    //     Future.delayed(Duration(milliseconds: 5), () {
    //       print("Dashboard Page Route");
    //       NavService.dashboard();
    //       print(authService.user?.email);
    //       print(authService.user?.AdvFinApp);
    //     });
    //   }
    // // else {
    // //   Future.delayed(Duration(milliseconds: 5), () {
    // //     print("Dashboard Page Route");
    // //     NavService.dashboard();
    // //     print(authService.user?.email);
    // //     print(authService.user?.AdvFinApp);
    // //   });
    // // }
  }
}
