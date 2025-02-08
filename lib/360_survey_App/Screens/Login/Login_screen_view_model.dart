import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../Ess_App/src/base/utils/constants.dart';
import '../../../Ess_App/src/services/local/navigation_service.dart';
import '../../Api_services/data/Local_services/Session.dart';
import '../../Api_services/data/network/Api_services.dart';
import '../../Models/Login_model.dart';
import '../Dashboard/Dashboard_view.dart';



class SurveyLoginViewModel extends ChangeNotifier
   {

     TextEditingController emailcontroller=TextEditingController();
     TextEditingController passwordcontroller=TextEditingController();
     Sharedprefrence sp=Sharedprefrence();
     Api api=Api();
     bool isLoading = false;



     Future<void> login(BuildContext context) async {
       if (emailcontroller.text.isEmpty) {
         Constants.customWarningSnack(context, "Please Enter Your Email");
         return null;
       }
       if (passwordcontroller.text.isEmpty) {
         Constants.customWarningSnack(context, "Please Enter Your Password");
         return null;
       }
       isLoading = true; // Set loading state to true
       notifyListeners(); // Notify listeners to rebuild the UI

       try {
         LoginResponse data = await api.loginapi(
             emailcontroller.text, passwordcontroller.text);
         if (data.data.code == '200') {
           print(data);
           print(data.data.empCode);
           await sp.savedata(data);
           emailcontroller.clear();
           passwordcontroller.clear();
           NavService.survey_dashboard();
           // Navigator.of(context).pushAndRemoveUntil(
           // //   MaterialPageRoute(builder: (context) => DashboardScreen()),
           // //       (Route<dynamic> route) => false,
           // // );
           Constants.customSuccessSnack(context, data.data.loginMsg!);
           await sp.getdata();
         }
         else {
           isLoading = false;
           Constants.customErrorSnack(context, data.data.loginMsg!);
           print("Invalid Credentails");
              }

       } catch (e) {
         print(e);
         // Handle errors
       } finally {
         isLoading = false; // Reset loading state
         notifyListeners(); // Notify listeners again to rebuild the UI
       }
     }
   }
