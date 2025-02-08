import 'package:ess/Ess_App/src/models/api_response_models/Hod_loan_approval.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/fetch_loan_approval.dart';
import '../../../models/api_response_models/pending_guaranted.dart';

class pending_hod_view_model extends ReactiveViewModel with AuthViewModel, ApiViewModel {


  @override
  void dispose() {
    New_loan_amt.forEach((element) {element.dispose();});
    loan_repay_tenure.forEach((element) {element.dispose();});
    resultController.forEach((element) {element.dispose();});
    super.dispose();
  }

  List<String?> selectedvisitStatusList=["Select your decision"];

  List<String> dropdownValues = ["Select your decision", "Approved", "Rejected"];
  List<LoanForm> loanlistfinal=[];
 // List<TextEditingController>
  TextEditingController comment=TextEditingController();
  List<TextEditingController> New_loan_amt=[];
  List<TextEditingController> loan_repay_tenure=[];
  List<TextEditingController> loan_installment=[];
  List<TextEditingController> resultController=[];
  List<String> url=[];

  init(BuildContext context) async {

    await getvisitApprovalData(context);
    selectedvisitStatusList = List.generate(
      loanlistfinal.length, (index) => "Select your decision",);
    url = List.generate(
      loanlistfinal.length, (index) => "Select your decision",);
    New_loan_amt = List.generate(loanlistfinal.length, (_) => TextEditingController());
    loan_repay_tenure = List.generate(loanlistfinal.length, (_) => TextEditingController());
    loan_installment = List.generate(loanlistfinal.length, (_) => TextEditingController());
    resultController = List.generate(loanlistfinal.length, (_) => TextEditingController());


    for (int i = 0; i < loanlistfinal.length; i++) {
      New_loan_amt[i].addListener(() => calculateMonthlyAmount(i));
      loan_repay_tenure[i].addListener(() => calculateMonthlyAmount(i));
    }

  }


  void calculateMonthlyAmount(int index) {
    double loanAmount = double.tryParse(New_loan_amt[index].text) ?? 0.0;
    double repayMonth = double.tryParse(loan_repay_tenure[index].text) ?? 1.0; // Default to 1 if parsing fails or value is 0
    double monthlyAmount = loanAmount / repayMonth;
    resultController[index].text = monthlyAmount.round().toString(); // Format the result to 2 decimal places
  }

  getvisitApprovalData(
      BuildContext context,
      ) async {
    var newsResponse = await runBusyFuture(apiService.loan_approval_hod());
    newsResponse.when(success: (data) async {
      if ((data?.approvalListvisit.length ?? 0) > 0) {
        loanlistfinal = data.approvalListvisit?.reversed.toList() ?? [];



      } else {
        Constants.customWarningSnack(context, "Loan Approval not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
    update(BuildContext context , String loanid, int index) async {
    var response = await apiService.updateloan( loanid, New_loan_amt[index].text, loan_repay_tenure[index].text, resultController[index].text);
    response.when(success: (data)
        async {
          if (data["status"] == "200")
            {
             //
              print(data["status_message"].toString());
              Constants.customSuccessSnack(context, data["status_message"]);
              getvisitApprovalData(context);
               notifyListeners();

            }
          else {
            Constants.customErrorSnack(context, data["status_message"]);
            print(data["status"].toString());
            notifyListeners();

          }
        },
        failure: (error){
      print(error);
          Constants.customErrorSnack(context, error.toString());
    });
    }

}


