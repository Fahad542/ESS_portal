import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import '../../base/utils/constants.dart';
import '../../shared/bottons.dart';
import '../../shared/input_field.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import 'customsearchabledropdown.dart';
import 'customtextfeild.dart';
import 'loan_view_model.dart';
import 'package:intl/intl.dart';

class Loan extends StatefulWidget {
  @override
  State<Loan> createState() => _LoanState();
}

class _LoanState extends State<Loan> {




  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<LoanViewModel>.reactive(
      builder: (viewModelContext, model, child) =>
          Scaffold(

            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: ListView(
                children: [
                  GeneralAppBar(
                      title: "Loan",
                      onMenuTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      onNotificationTap: () {}),


                  model.isBusy
                      ? Center(child: LoadingIndicator())
                      : SizedBox(
                    height: context
                        .screenSize()
                        .height - 145,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomSearchableDropDown(
                                items: model.loan_applicants,
                                label: model.loan_applicants[0],
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: const Color(0xff3E4684)),
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: model.loan_applicants,

                                onChanged: (value) {
                                  FocusScope.of(context).unfocus();
                                  if (value != null && value is String) {
                                    setState(() {
                                      if(value=="Self"){
                                       // value="for_self";
                                     model.loanapplicants = "for_self";
                                        print("Selected value: ${model.loanapplicants}");}
                                     else if(value=="For Employee"){
                                        value="for_employee";
                                        model.loanapplicants = value;
                                        print("Selected value: $value");
                                      }

                                    });
                                  } else {
                                    // Handle null or unexpected value
                                  }
                                },

                              ),

                              SizedBox(height: 10,),

                              CustomSearchableDropDown(
                                items: model.finalApprovalData,
                                label: model.selectedValue == '' ? 'Branch List' : 'Select Loan Type',
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: AppColors.primary),
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: model.finalApprovalData
                                    .map((item) => item.loanTypeName)
                                    .toList(),
                                onChanged: (value) {
                                  FocusScope.of(context).unfocus();
                                  if (value != null) {
                                    setState(() {
                                      model.selectedValue = value.loanTypeId.toString();
                                      print("Selected value: $value");
                                    });
                                  }
                                },
                              ),
SizedBox(height: 10,),


                              CustomTextField(
                                controller: model.namecontroller,
                                labelText: 'Name',
                              ),

                              SizedBox(height: 10,),
                              CustomTextField(
                                controller: model.positioncontroller,
                                labelText: 'Position',
                              ),
                              SizedBox(height: 10,),
                              CustomTextField(
                                controller: model.departmentcontroller,
                                labelText: 'Department',
                              ),
                              SizedBox(height: 10,),

                                  CustomSearchableDropDown(
                                    items: model.branchlist,
                                    label: model.branchvalue == '' ? 'Branch List' : 'Select Branch',
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(color: const Color(0xff3E4684)),
                                    ),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(Icons.search),
                                    ),
                                    dropDownMenuItems: model.branchlist
                                        .map((item) => item.branch_name)
                                        .toList(),
                                    onChanged: (value) {
                                      FocusScope.of(context).unfocus();
                                      if (value != null) {
                                        setState(() {
                                          model.branchvalue = value.bms_code.toString();
                                          print("Selected value: $value");
                                        });
                                      } else {
                                        setState(() {
                                          model.selectedgraduatevalue2 = '';
                                        });
                                      }
                                    },
                                  ),


                              SizedBox(height: 10,),

                              CustomSearchableDropDown(
                                items: model.pre_code,
                                label: model.precodevalue == '' ? 'Branch List' : 'Select Pre Code',
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: const Color(0xff3E4684)),
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: model.pre_code,

                                onChanged: (value) {
                                  FocusScope.of(context).unfocus();
                                  if (value != null && value is String) {
                                    setState(() {
                                      model.precodevalue = value; // Assuming precodevalue is a String
                                      print("Selected value: $value");
                                    });
                                  } else {
                                    // Handle null or unexpected value
                                  }
                                },

                              ),



                              SizedBox(height: 10,),
                              CustomTextField(
                                controller: model.empcodecontroller,
                                labelText: 'Emp Code',
                                inputType: TextInputType.number,
                              ),
                              SizedBox(height: 10,),
                              CustomTextField(
                                controller: model.mobilenumbercontroller,
                                labelText: 'Mobile Number',
                                inputType: TextInputType.number,
                              ),
                              SizedBox(height: 10,),
                              // CustomTextField(
                              //   controller: model.dateofjoningcontroller,
                              //   labelText: 'Date of joining',
                              // ),
                              SecondInputField(
                                label: 'Date of joining',
                                hint: 'Select Booking Date',
                                controller: model.dateofjoningcontroller,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(2100), firstDate: DateTime(1900),
                                    // Remove the firstDate constraint to allow selecting previous dates
                                  );

                                  if (pickedDate != null) {
                                    model.bookDateFormat = pickedDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.dateofjoningcontroller.text = formattedDate;
                                    model.notifyListeners();
                                  }
                                },
                                message: 'Please select booking date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),

                              SizedBox(height: 30,),
                              CustomTextField(
                                controller: model.cniccontroller,
                                labelText: 'CNIC',
                                inputType: TextInputType.number,
                                formatter: [CnicFormatter()],

                              ),
                              SizedBox(height: 30,),
                              CustomTextField(
                                controller: model.loanamountrs,
                                labelText: 'Loan Amount Rs',
                                inputType: TextInputType.number,
                              ),
                              SizedBox(height: 30,),
                              CustomTextField(
                                controller: model.loanamountinwordscontroller,
                                labelText: 'Loan Amount In Words',
                              ),
                              SizedBox(height: 30,),
                              CustomTextField(
                                controller: model.purposeofloancontroller,
                                labelText: 'Purpose of loan',
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ElevatedButton(
                                    onPressed: () async {
                                      model.getImageCamera();

                                    },
                                    child: Text("Upload Attachments"),
                                  ),
                                  if(model.imagepath.isNotEmpty)
                                    Text(
                                      model.imagepath.split('/').last, // Extracts the file name from the path
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Text(" I solemnly affirm that the application of loan is made to meet expenses stated as the purpose already mentioned above."),
                         //Text("number of equal monthly INSTALLMENT of Rs  "),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Wrap(
                                      children: [
                                        Text("I will repay the loan in "),
                                        SizedBox(
                                          width: 100,
                                          child: CustomTextField(
                                            controller: model.repay_loan_month_controller,
                                            labelText: '',
                                            inputType: TextInputType.number,
                                          ),
                                        ),
                                        Text(" number of equal monthly INSTALLMENT of Rs "),

                                        SizedBox(
                                          width: 100,child:
                                         CustomTextField(
                                              controller: model.resultController,
                                              labelText: '',
                                           editable: false,

                                            ),
                                          ),

                                        Text(", as the repayment of the principal, payment of mark-up (if-opted) as per the rules of employee loan facility will be over and above the installment of the principal."),
                                      ],
                                    ),

                                ],
                              ),








                              SizedBox(height: 10,),
                              Visibility(
                                visible: model.loanapplicants=="for_self",
                                child:
                                CustomSearchableDropDown(
                                  items: model.finalguaranterlist1,
                                  label: model.selectedgraduatevalue1 == '' ? 'Branch List' : 'Select Guarantor 1',
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: const Color(0xff3E4684)),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(Icons.search),
                                  ),
                                  dropDownMenuItems: model.finalguaranterlist1
                                      .map((item) => item.member_name)
                                      .toList(),
                                  onChanged: (value) {
                                    FocusScope.of(context).unfocus();
                                    if (value != null) {
                                      setState(() {
                                        model.selectedgraduatevalue1 = value.member_code.toString();
                                        print("Selected value: $value");
                                      });
                                    } else {
                                      setState(() {
                                        model.selectedgraduatevalue1 = '';
                                      });
                                    }
                                  },
                                ),


                              ),


                              SizedBox(height: 30,),

                              Visibility(
                                visible: model.loanapplicants=="for_self",
                                child:
                                CustomSearchableDropDown(
                                  items: model.finalguaranterlist2,
                                  label: model.selectedgraduatevalue2 == '' ? 'Branch List' : 'Select Guarantor 2',
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: const Color(0xff3E4684)),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(Icons.search),
                                  ),
                                  dropDownMenuItems: model.finalguaranterlist2
                                      .map((item) => item.member_name)
                                      .toList(),
                                  onChanged: (value) {
                                    FocusScope.of(context).unfocus();
                                    if (value != null) {
                                      setState(() {
                                        model.selectedgraduatevalue2 = value.member_code.toString();
                                        print("Selected value: $value");
                                      });
                                    } else {
                                      setState(() {
                                        model.selectedgraduatevalue2 = '';
                                      });
                                    }
                                  },
                                ),


                              ),

                              SizedBox(height: 30,),
                              MainButton(
                                text: "Apply Loan",
                                isBusy: model.isBusy,
                                onTap: () {
                                  if (model.namecontroller.text.isNotEmpty &&
                                      model.positioncontroller.text.isNotEmpty &&
                                      model.departmentcontroller.text.isNotEmpty &&
                                      model.precodevalue != null &&
                                      model.branchvalue != null &&
                                        model.imagepath.isNotEmpty &&
                                      model.empcodecontroller.text.isNotEmpty &&
                                      model.mobilenumbercontroller.text.isNotEmpty &&
                                      model.dateofjoningcontroller.text.isNotEmpty &&
                                      model.cniccontroller.text.isNotEmpty &&
                                      model.loanamountrs.text.isNotEmpty &&
                                      model.loanamountinwordscontroller.text.isNotEmpty &&
                                      model.purposeofloancontroller.text.isNotEmpty &&
                                      ((model.selectedValue != "pf_permanent_withdrawl" &&
                                          model.repay_loan_month_controller.text.isNotEmpty &&
                                          model.resultController.text.isNotEmpty) ||
                                          model.selectedValue == "pf_permanent_withdrawl")) {
                                    // Validate mobile number length
                                    if (model.mobilenumbercontroller.text.length >= 11 &&
                                        model.mobilenumbercontroller.text.length <= 11) {
                                      model.applyloan(context);
                                    } else {
                                      Constants.customErrorSnack(
                                          context, "Please enter a valid mobile number");
                                    }
                                  } else {
                                    Constants.customErrorSnack(
                                        context, "Please fill in all fields");
                                  }
                                },
                              ),
                            ],
                          ),




                          ),

                    ),
                  ),
                  )],
              ),
            ),
          ),
      viewModelBuilder: () => LoanViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }

}
class CnicFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < text.length; i++) {
      if (i == 5 || i == 12) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
