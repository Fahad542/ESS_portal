import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../My_models/final_advancce_model.dart';
import '../../base/utils/constants.dart';
import '../../services/local/base/auth_view_model.dart';

// class final_advance_viewmodel extends ReactiveViewModel
//     with AuthViewModel, ApiViewModel

class final_advance_viewmodel extends ReactiveViewModel with AuthViewModel, ApiViewModel
{
  List<finalItem> finalapprovaldata = [];

  List<String?> selectedvisitStatusList=["Select Status"];

  init(BuildContext context) async {
    await gefinalApprovalData(context);
    selectedvisitStatusList = List.generate(
      finalapprovaldata.length,
          (index) => "Select Status",);

  }
  gefinalApprovalData(
      BuildContext context,
      ) async {
    var newsResponse = await runBusyFuture(apiService.finaladvanceapproval(context));
    newsResponse.when(success: (data) async {
      if ((data.approvalItems?.length ?? 0) > 0) {
        finalapprovaldata = data.approvalItems?.reversed.toList() ?? [];


      } else {
        Constants.customWarningSnack(context, "Approval not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}

