import 'package:ess/Ess_App/My_models/pending_visit_approval.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../services/remote/base/api_view_model.dart';


class visitviewmodel extends ReactiveViewModel
with AuthViewModel, ApiViewModel
{
    List<ApprovalVisitList> visitapprovaldata = [];

  List<String?> selectedvisitStatusList=["Select Status"];

  init(BuildContext context) async {
  await getvisitApprovalData(context);
  selectedvisitStatusList = List.generate(
  visitapprovaldata.length,
  (index) => "Select Status",);

  }
    getvisitApprovalData(
        BuildContext context,
        ) async {
      var newsResponse = await runBusyFuture(apiService.visitapproval(context));
      newsResponse.when(success: (data) async {
        if ((data.approvalListvisit?.length ?? 0) > 0) {
          visitapprovaldata = data.approvalListvisit?.reversed.toList() ?? [];


        } else {
          Constants.customWarningSnack(context, "Approval not found");
        }
      }, failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      });
    }
}

