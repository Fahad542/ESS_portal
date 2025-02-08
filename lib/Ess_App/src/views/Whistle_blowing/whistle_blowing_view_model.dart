import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../base/utils/constants.dart';

class WhistleblowingViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();

clear(){
  titlecontroller.clear();
  detailcontroller.clear();
}


  init(BuildContext context) async {
  }
  Future<void> applywhistle(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.applywhistle(
      context,
      titlecontroller.text,
      detailcontroller.text)); newsResponse.when(
      success: (data) {
        newsResponse.when(
          success: (data) {
            if (data == "Whistle Blow Successfully") {
              clear();
              Constants.customSuccessSnack(
                  context, "Whistle Blow Submitted Successfully");
            } else {
              Constants.customErrorSnack(
                  context, "Sorry , Something went wrong please try again");
            }
          },
          failure: (error) {
            Constants.customErrorSnack(context, error.toString());
          },
        );
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
  }
  }
