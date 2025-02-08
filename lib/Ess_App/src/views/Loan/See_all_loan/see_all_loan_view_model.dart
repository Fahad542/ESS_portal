import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/fetch_loan_approval.dart';
import '../../../services/local/base/auth_view_model.dart';
import '../../../services/remote/base/api_view_model.dart';

class AllLoanViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {
  List<loanList> loanlistfinal = [];

  @override
  void dispose() {

    super.dispose();
  }


  init(BuildContext context) async {

    getvisitApprovalData(context);
  }
  getvisitApprovalData(
      BuildContext context,
      ) async {
    var newsResponse = await runBusyFuture(apiService.fetchloanapi(context));
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

  }


