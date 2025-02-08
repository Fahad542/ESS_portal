import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../base/utils/constants.dart';
import '../../models/api_response_models/branch.dart';
import '../../models/api_response_models/guaranter.dart';
import '../../models/api_response_models/loan_model.dart';
import '../../services/local/base/auth_view_model.dart';
import '../../services/local/navigation_service.dart';
import '../../services/remote/base/api_view_model.dart';
class LoanViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {
  List<finalloan> finalApprovalData = [];
  List<finalguaranter> finalguaranterlist1 = [];
  List<finalbranch> branchlist = [];
   List<finalguaranter> finalguaranterlist2 = [];
  List<String> loan_applicants = ["Self","For Employee"];
  List<String> pre_code = ["999","998"];
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController positioncontroller = TextEditingController();
  final TextEditingController departmentcontroller = TextEditingController();
  final TextEditingController branchcontroller = TextEditingController();
  final TextEditingController empcodecontroller = TextEditingController();
  final TextEditingController mobilenumbercontroller = TextEditingController();
  final TextEditingController dateofjoningcontroller = TextEditingController();
  final TextEditingController cniccontroller = TextEditingController();
  final TextEditingController loanamountinwordscontroller = TextEditingController();
  final TextEditingController loanamountrs = TextEditingController();
  final TextEditingController purposeofloancontroller = TextEditingController();
  final TextEditingController repaymonthlyamount = TextEditingController();
  final TextEditingController repay_loan_month_controller = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  DateTime bookDateFormat = DateTime.now();
  @override
  void dispose() {
    loanamountrs.dispose();
    repay_loan_month_controller.dispose();
    repaymonthlyamount.dispose();
    resultController.dispose();
    super.dispose();
  }
  String? selectedValue;
  String? loanapplicants;
     String? selectedgraduatevalue1;
     String? selectedgraduatevalue2;
  String? branchvalue;
  String? precodevalue;
  LoanViewModel() {

   // loanamountrs.addListener(calculateMonthlyAmount);
    repay_loan_month_controller.addListener(calculateMonthlyAmount);
  }
  String imagepath = "";
  ImagePicker picker = ImagePicker();

  Future<void> getImageCamera() async {
    try {
      // final result = await FilePicker.platform.pickFiles(
      //   type: FileType.custom,
      //   allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png',],
      // );

      // if (result != null) {
      //   final pickedFile = result.files.first;

        // if (pickedFile.extension == 'pdf') {
        //   imagepath = pickedFile.path!;
        //   notifyListeners();
        // } else {
          // Handle image file
          final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            imagepath = pickedImage.path;
            notifyListeners();
          }
        //}
    //  }
    } catch (e) {
      print('Error picking file: $e');
    }
  }
  void calculateMonthlyAmount() {
    double loanAmount = double.tryParse(loanamountrs.text) ?? 0.0;
    double repayMonth = double.tryParse(repay_loan_month_controller.text) ?? 1.0; // Default to 1 if parsing fails or value is 0

    // Calculate monthly amount and update the resultController text
    double monthlyAmount = loanAmount / repayMonth;
    resultController.text = monthlyAmount.round().toString(); // Format the result to 2 decimal places
  }

  init(BuildContext context) async {

    await getFinalApprovalData(context);
          await guaranterdata(context);
          await branchdata(context);




    // The finalApprovalData list may not be populated here
  }

  Future<void> getFinalApprovalData(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.loanapproval(context));
    newsResponse.when(
      success: (data) {
        // Append data to finalApprovalData
        finalApprovalData=data.approvalItems;

        print(finalApprovalData);
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
  }
  clear(){
   namecontroller.clear();
   positioncontroller.clear();
   departmentcontroller.clear();
   branchcontroller.clear();
   empcodecontroller.clear();
   mobilenumbercontroller.clear();
   dateofjoningcontroller.clear();
   cniccontroller.clear();
   loanamountinwordscontroller.clear();
   loanamountrs.clear();
   purposeofloancontroller.clear();
   repaymonthlyamount.clear();
   repay_loan_month_controller.clear();
   selectedValue=null;
   selectedgraduatevalue1=null;
   selectedgraduatevalue2=null;
   precodevalue=null;
   branchvalue=null;
   imagepath='';
  }

  Future<void> guaranterdata(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.guaranterapi(context));
    newsResponse.when(
      success: (data) {
        // Append data to finalApprovalData
        finalguaranterlist1=data.approvalItems;
           finalguaranterlist2=data.approvalItems;
        print(finalApprovalData);
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
  }
  Future<void> branchdata(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.branchapi(context));
    newsResponse.when(
      success: (data) {
        // Append data to finalApprovalData
        branchlist=data.approvalItems;

      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
  }
  Future<void> applyloan(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.applyloan(
      context,
      loanapplicants.toString(),
      selectedValue.toString(),
      namecontroller.text,
      positioncontroller.text,
      departmentcontroller.text,
      branchvalue.toString(),
      precodevalue.toString(),
      empcodecontroller.text,
      mobilenumbercontroller.text,
      dateofjoningcontroller.text,
      cniccontroller.text,
      loanamountrs.text,
      loanamountinwordscontroller.text,
      purposeofloancontroller.text,
      repay_loan_month_controller.text,
      resultController.text,
      selectedgraduatevalue1.toString(),
      selectedgraduatevalue2.toString(),
        imagepath


    ));

    newsResponse.when(
      success: (data) {
        newsResponse.when(
          success: (data) {
            if (data == "Loan Submitted Successfully") {
             clear();
             NavService.allloan();
              Constants.customSuccessSnack(
                  context, "Your Application Submitted Successfully");

            } else {
              Constants.customErrorSnack(
                  context, "Your Application Not Submit, Try Again");
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

