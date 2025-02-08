import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/fetch_loan_approval.dart';
import '../../../models/api_response_models/pending_guaranted.dart';

class guarantees_view_model extends ReactiveViewModel with AuthViewModel, ApiViewModel {


  @override
  void dispose() {

    super.dispose();
  }
  List<String?> selectedvisitStatusList=["Select your decision"];
  List<String> dropdownValues = ["Select your decision", "I Guratranteed !", "I Wont be responsible"];
List<Pending> loanlistfinal=[];
  init(BuildContext context) async {
    await getvisitApprovalData(context);
    selectedvisitStatusList = List.generate(
      loanlistfinal.length,
          (index) => "Select your decision",);

  }
  getvisitApprovalData(
      BuildContext context,
      ) async {
    var newsResponse = await runBusyFuture(apiService.pendingguaranter(context));
    newsResponse.when(success: (data) async {
      if ((data.approvalListVisit?.length ?? 0) > 0) {
        loanlistfinal = data.approvalListVisit?.reversed.toList() ?? [];


      } else {
        Constants.customWarningSnack(context, "Guarantees not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }


}


