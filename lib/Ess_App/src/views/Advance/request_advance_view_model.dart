import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../base/utils/constants.dart';

class requestadvanceViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel{

  TextEditingController Advance_amount = TextEditingController();
  TextEditingController Reason = TextEditingController();
  init(BuildContext context) async {
    setBusy(true);

    setBusy(false);
  }
  clear(){
    Advance_amount.clear();
    Reason.clear();
  }
  Future<void> applyrequest_advanced(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.applyrequestadvancec(
        context,
        Advance_amount.text,
        Reason.text)); newsResponse.when(
      success: (data) {
        newsResponse.when(
          success: (data) {
            if (data == "Advance Successfully Submitted") {
              clear();
              Constants.customSuccessSnack(context, data);
            } else {
              Constants.customErrorSnack(context, data);
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
