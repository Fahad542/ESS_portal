import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../My_models/user_model.dart';
import '../../base/utils/constants.dart';
import '../../services/local/base/auth_view_model.dart';
import '../../services/remote/base/api_view_model.dart';

class Approval extends ReactiveViewModel

    with AuthViewModel, ApiViewModel{

  List<ApprovalList> approvaluserdata = [];

  List<String?> selectedStatusList=["Select Status"];

  init(BuildContext context) async {
    await getApprovalData(context);
    selectedStatusList = List.generate(
      approvaluserdata.length,
    (index) => "Select Status",);

  }
getApprovalData(
    BuildContext context,
    ) async {
  var newsResponse = await runBusyFuture(apiService.approval(context));
  newsResponse.when(success: (data) async {
    if ((data.approvalList?.length ?? 0) > 0) {
      approvaluserdata = data.approvalList?.reversed.toList() ?? [];

    } else {
      Constants.customWarningSnack(context, "Approval not found");
    }
  }, failure: (error) {
    Constants.customErrorSnack(context, error.toString());
  });
}


  // statusmsg(BuildContext context, String Status , String id) async {
  //   var newsResponse = await runBusyFuture(apiService.status(context, Status,id));
  //   newsResponse.when(success: (data) async {
  //     if (data == "Leave from Approved") {
  //       Constants.customSuccessSnack(context, "Request is Approved");
  //     } else if
  //     (data == "Request is Approved")
  //     {
  //       Constants.customErrorSnack(context, "Leave from Rejected");
  //     }
  //   }, failure: (error) {
  //     Constants.customErrorSnack(context, error.toString());
  //   });
  // }
  // getDropdownValuesAndApprovalData(BuildContext context, String Status , String id) async {
  //   var dropdownResponse = await runBusyFuture(apiService.status(context, Status,id));
  //   dropdownResponse.when(success: (data) async {
  //     dropdownValues = data. ?? [];
  //     await getApprovalData(context);
  //   }, failure: (error) {
  //     Constants.customErrorSnack(context, error.toString());
  //   });
  // }

}