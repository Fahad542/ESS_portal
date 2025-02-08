import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/input_field.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/apply_leave/apply_leave_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ApplyLeaveView extends StatelessWidget {
  final String? date;
  const ApplyLeaveView({Key? key, this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplyLeaveViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Apply Leave",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();},

                  onNotificationTap: () {}
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      child: Builder(
                        builder: (ctx) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SecondInputField(
                                label: 'Employee Code',
                                hint: 'Enter Employee Code',
                                controller: model.employeeCode,
                                inputType: TextInputType.text,
                                readOnly: true,
                                onTap: () {

                                },
                                message: 'Please enter employee code',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Employee Position',
                                hint: 'Enter Employee Position',
                                controller: model.employeePosition,
                                inputType: TextInputType.text,
                                onTap: () {

                                },
                                message: 'Please enter employee position',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'From Date',
                                hint: 'Select From Date',
                                controller: model.fromDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2100));


                                  if (pickedDate != null) {
                                    model.toDateFormat = pickedDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.fromDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {

                                  }
                                },
                                message: 'Please select from Date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'To Date',
                                hint: 'Select To Date',
                                controller: model.toDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: model.toDateFormat,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.toDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {

                                  }
                                },
                                message: 'Please select to date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              CustomDropDown(
                                value: model.leaveTypes[model.typeSelectedIndex],
                                items: model.leaveTypes.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.typeSelectedIndex = model.leaveTypes.indexWhere((element) => element == newValue);
                                  model.notifyListeners();
                                },
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Reason',
                                hint: 'Enter Reason',
                                controller: model.leaveReason,
                                inputType: TextInputType.multiline,
                                onTap: (){},
                                message: 'Please enter reason',
                              ),
                              VerticalSpacing(20),
                              MainButton(
                                  text: "Apply",
                                  isBusy: model.isBusy,
                                  onTap: () {
                                    model.apply(ctx);
                                  }),
                              VerticalSpacing(20),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ApplyLeaveViewModel(date),
      onModelReady: (model) => model.init(context),
    );
  }
}
