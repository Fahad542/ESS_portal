import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../360_survey_App/Api_services/data/Local_services/Session.dart';
import '../../../360_survey_App/Api_services/data/network/Api_services.dart';
import '../../../Ess_App/src/base/utils/constants.dart';
import '../../../Ess_App/src/services/local/navigation_service.dart';
import '../../Models/Login_model.dart';
import '../Lms_Dashboard/Lms_dashboard_view.dart';




class lmsLoginViewModel extends ChangeNotifier
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
      LmsloginResponse data = await api.lmslogin(
          emailcontroller.text, passwordcontroller.text);
      if (data.code == '200') {
        //if(data.datalist)
        print("datalist: ${data.datalist}");
        await sp.savelmsdata(data.datalist);
        await sp.getlmsdata();
        emailcontroller.clear();
        passwordcontroller.clear();
        //NavService.survey_dashboard();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => lms_Dashboard()),

        );
        Constants.customSuccessSnack(context, data.msg);
        await sp.getdata();
      }
      else {
        isLoading = false;
        Constants.customErrorSnack(context, data.msg);
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
