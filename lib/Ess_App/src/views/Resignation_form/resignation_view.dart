import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/views/Resignation_form/resignation_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../base/utils/constants.dart';
import '../../shared/bottons.dart';
import '../../shared/input_field.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../Loan/customsearchabledropdown.dart';
import '../Loan/customtextfeild.dart';
import 'package:intl/intl.dart';


class resignation_form extends StatefulWidget {
  @override
  State<resignation_form> createState() => _LoanState();
}

class _LoanState extends State<resignation_form> {

  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<ResignationViewModel>.reactive(
        builder: (viewModelContext, model, child) =>
            Scaffold(

              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: ListView(
                  children: [
                    GeneralAppBar(
                        title: "Resignation Form",
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
                                CustomTextField(
                                  controller: model.empcodecontroller,
                                  labelText: 'Emp Code',
                                  inputType: TextInputType.number,
                                ),
                                SizedBox(height: 10,),
                                CustomTextField(
                                  controller: model.namecontroller,
                                  labelText: 'Name',
                                ),

                                SizedBox(height: 10,),
                                CustomTextField(
                                  controller: model.departmentcontroller,
                                  labelText: 'Department',
                                ),



                                SizedBox(height: 10,),
                                CustomSearchableDropDown(
                                  items: model.regions,
                                  label: model.regionvalue == '' ? 'Branch List' : 'Select Region',
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: const Color(0xff3E4684)),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(Icons.search),
                                  ),
                                  dropDownMenuItems: model.regions
                                      .map((item) => item.regionName)
                                      .toList(),
                                  onChanged: (value) {
                                    FocusScope.of(context).unfocus();
                                    if (value != null) {
                                      setState(() {
                                        model.regionvalue = value.regionName.toString();
                                        print("Selected value: $value");
                                      });
                                    }
                                  },
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
                                        model.branchvalue = value.branch_name.toString();
                                        print("Selected value: $value");
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: 10,),


                                SecondInputField(
                                  label: 'Date of joining',
                                  hint: 'Select Booking Date',
                                  controller: model.startdatecontroller,
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
                                      model.startdatecontroller.text = formattedDate;
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
                                SizedBox(height: 10,),
                                SecondInputField(
                                  label: 'Date of Resign',
                                  hint: 'Select Booking Date',
                                  controller: model.enddatecontroller,
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
                                      model.enddatecontroller.text = formattedDate;
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
                                SizedBox(height: 10,),
                                CustomTextField(
                                  controller: model.mobilenumbercontroller,
                                  labelText: 'Mobile Number',
                                  inputType: TextInputType.number,
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






                                SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("I, S/O"),
                                        SizedBox(width: 10), // Add some space between the Text and TextFormField
                                        Expanded(
                                          child: CustomTextField(
                                            controller: model.fathernamecontroller,
                                            labelText: 'Father Name',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Bearing CNIC #"),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child:  CustomTextField(
                                            controller: model.cniccontroller,
                                            labelText: 'CNIC Number',
                                            inputType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("working as"),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child:  CustomTextField(
                                            controller: model.jobcontroller,
                                            labelText: 'Job Title',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("would like to resign from my services due to"),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child:  CustomTextField(
                                            controller: model.reasoncontroller,
                                            labelText: 'Reason',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("please accept my resign along with the notice period of"),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText: 'Enter the notice period in days',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            inputType: TextInputType.number,
                                            controller: model.noticeperiod,
                                            labelText: 'Notice Period',
                                          ),
                                        ),
                                        Text(" days. My last working day would be"),
                                        SizedBox(width: 10),

                                      ],
                                    ),
                                    SecondInputField(

                                      hint: 'Select Booking Date',
                                      controller: model.lastdaycontroller,
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
                                          model.lastdaycontroller.text = formattedDate;
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
                                  ],
                                ),


                                SizedBox(height: 30,),
                                MainButton(
                                  text: "Apply Resignation",
                                  isBusy: model.isBusy,
                                  onTap: () {
                                    print("image: ${model.imagepath}");
                                    if (
                                        model.namecontroller.text.isNotEmpty &&
                                        model.departmentcontroller.text.isNotEmpty &&
                                            model.imagepath.isNotEmpty &&
                                        model.branchvalue != null &&
                                        model.empcodecontroller.text.isNotEmpty &&
                                        model.mobilenumbercontroller.text.isNotEmpty &&
                                        model.startdatecontroller.text.isNotEmpty && model.fathernamecontroller.text.isNotEmpty
                                        && model.cniccontroller.text.isNotEmpty && model.jobcontroller.text.isNotEmpty
                                        && model.reasoncontroller.text.isNotEmpty  && model.lastdaycontroller.text.isNotEmpty
                                        ) {
                                    print("object");
                                        model.applyresignation(context);
                                      }
                                      else {

                                        Constants.customErrorSnack(
                                            context, "Please enter all Feilds");
                                      }
                                   }

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
        viewModelBuilder: () => ResignationViewModel(),
        onModelReady: (model) => model.init(context),
      );
  }
}