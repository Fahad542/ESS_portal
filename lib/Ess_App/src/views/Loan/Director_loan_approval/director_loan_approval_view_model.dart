import 'package:ess/Ess_App/src/models/api_response_models/Hod_loan_approval.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/director_model.dart';
import '../../../models/api_response_models/loan_model.dart';


class director_loan_view_model extends ReactiveViewModel with AuthViewModel, ApiViewModel {
  @override
  void dispose() {
    New_loan_amt.forEach((element) {element.dispose();});
    loan_repay_tenure.forEach((element) {element.dispose();});
    resultController.forEach((element) {element.dispose();});
    super.dispose();
  }

  List<String?> selectedvisitStatusList=["Select your decision"];

  List<String> dropdownValues = ["Select your decision", "Approved", "Rejected"];
  List<directorForm> loanlistfinal=[];
  List<finalloan> finalApprovalData = [];
  List<String> selectedValue=[] ;

  TextEditingController comment=TextEditingController();
  List<TextEditingController> New_loan_amt=[];
  List<TextEditingController> loan_repay_tenure=[];
  List<TextEditingController> loan_installment=[];
  List<TextEditingController> from_company=[];
  List<TextEditingController> from_employee_pf=[];
  List<TextEditingController> resultController=[];
  init(BuildContext context) async {

    await getvisitApprovalData(context);
    await getFinalApprovalData(context);

    selectedvisitStatusList = List.generate(
      loanlistfinal.length, (index) => "Select your decision",);
    New_loan_amt = List.generate(loanlistfinal.length, (_) => TextEditingController());
    loan_repay_tenure = List.generate(loanlistfinal.length, (_) => TextEditingController());
    loan_installment = List.generate(loanlistfinal.length, (_) => TextEditingController());
    resultController = List.generate(loanlistfinal.length, (_) => TextEditingController());
    from_employee_pf = List.generate(loanlistfinal.length, (_) => TextEditingController());
    from_company = List.generate(loanlistfinal.length, (_) => TextEditingController());
   // selectedValue = List.generate(loanlistfinal.length, (_) => "");
     selectedValue = loanlistfinal.map((e) => e.loanType.toString()).toList();
     print(selectedValue);

    for (int i = 0; i < loanlistfinal.length; i++) {
      New_loan_amt[i].addListener(() => calculateMonthlyAmount(i));
      loan_repay_tenure[i].addListener(() => calculateMonthlyAmount(i));
    }

  }
  Future<void> getFinalApprovalData(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.loanapproval(context));
    newsResponse.when(
      success: (data) {

        finalApprovalData=data.approvalItems;

        print(finalApprovalData);
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
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
    var newsResponse = await runBusyFuture(apiService.director_loan_approval());
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
  update(BuildContext context, String loanid, int index) async {
    String fromCompanyValue = from_company[index].text.isEmpty ? '0' : from_company[index].text;
    String fromEmployeePfValue = from_employee_pf[index].text.isEmpty ? '0' : from_employee_pf[index].text;
    var response = await apiService.updateloandirector( loanid, New_loan_amt[index].text, loan_repay_tenure[index].text, resultController[index].text,fromCompanyValue, fromEmployeePfValue);
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
  updateloantype(BuildContext context, String loanid, int index) async {

    var response = await apiService.updateloantype(loanid, selectedValue[index].toString());
    response.when(success: (data)
    async {
      if (data["status"] == "200")
      {
        //
        print(data["status_message"].toString());
        Constants.customSuccessSnack(context, data["status_message"]);
        //getvisitApprovalData(context);
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


