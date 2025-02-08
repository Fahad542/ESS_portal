import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/advance_line_manager_approval.dart';

class LinemanagerViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {


  List<finalloanList> loanlistfinal = [];
  List<String?> selectedvisitStatusList=["Select Status"];



  init(BuildContext context) async {
   await line_manager(context);
    selectedvisitStatusList = List.generate(
      loanlistfinal.length,
          (index) => "Select Status",);

  }

  line_manager(BuildContext context,) async {
    var newsResponse = await runBusyFuture(
        apiService.line_manager_approval_api(context));
    newsResponse.when(success: (data) async {
      if ((data.approvalListvisit?.length ?? 0) > 0) {
        loanlistfinal = data.approvalListvisit?.reversed.toList() ?? [];
      } else {
        Constants.customWarningSnack(context, "Approval not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
  Future<void> approval(BuildContext context, String id, String value) async {
    var newsResponse = await runBusyFuture(apiService.linemanagerapp(
      context,id,value
    ));

    newsResponse.when(
      success: (data) {
        newsResponse.when(
          success: (data) {
            if (value == "approved") {

              Constants.customSuccessSnack(
                  context, data.toString());

            } else if (value == "rejected"){
              Constants.customErrorSnack(
                  context, data.toString());
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
