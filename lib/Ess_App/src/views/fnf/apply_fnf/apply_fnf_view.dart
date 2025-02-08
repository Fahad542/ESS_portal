import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/input_field.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/fnf/apply_fnf/apply_fnf_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ApplyFnfView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplyFnfViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Apply FnF",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {
                  }),
              (model.isBusy == true)
              ? Center(child: CircularProgressIndicator(color: AppColors.primary,))
              : Expanded(
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
                              CustomDropDown(
                                label: "Capex For",
                                value: model.fnfForList[model.fnfForIndex],
                                items: model.fnfForList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.fnfForIndex = model.fnfForList.indexWhere((element) => element == newValue);
                                  if(newValue == "Employee"){
                                    model.employeeCode.clear();
                                    model.empName.clear();
                                    model.empPosition.clear();
                                  }else if(newValue == "Self"){
                                    model.employeeCode.text = model.currentUser?.userId.toString() ?? "000000";
                                    model.empName.text = model.currentUser?.userName.toString() ?? "";
                                  }
                                  model.notifyListeners();
                                },
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Employee Code',
                                hint: 'Enter Employee Code',
                                controller: model.employeeCode,
                                inputType: TextInputType.text,
                                onTap: () {},
                                message: 'Please enter employee code',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Employee Name',
                                hint: 'Enter Employee Name',
                                controller: model.empName,
                                inputType: TextInputType.text,
                                onTap: () {},
                                message: 'Please enter employee name',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Employee Position',
                                hint: 'Enter Employee Position',
                                controller: model.empPosition,
                                inputType: TextInputType.text,
                                onTap: () {},
                                message: 'Please enter employee position',
                              ),
                              VerticalSpacing(20),
                              CustomDropDown(
                                label: "Branch",
                                value: model.branches[model.selectedBranchIndex].branchName ?? "",
                                items: model.branches.map((var items) {
                                  return DropdownMenuItem(
                                    value: items.branchName,
                                    child: Text(items.branchName ?? ""),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.selectedBranchIndex = model.branches.indexWhere((element) => element.branchName == newValue);
                                  model.notifyListeners();
                                },
                              ),
                              VerticalSpacing(20),
                              CustomDropDown(
                                label: "Region",
                                value: model.regions[model.selectedRegionIndex].regionName ?? "",
                                items: model.regions.map((var items) {
                                  return DropdownMenuItem(
                                    value: items.regionName,
                                    child: Text(items.regionName ?? ""),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.selectedRegionIndex = model.regions.indexWhere((element) => element.regionName == newValue);
                                  model.notifyListeners();
                                },
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Joining Date',
                                hint: 'Select Joining Date',
                                controller: model.joinDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2100));


                                  if (pickedDate != null) {
                                    model.joinDateFormat = pickedDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.joinDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {

                                  }
                                },
                                message: 'Please select joining Date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Resign Date',
                                hint: 'Select Resign Date',
                                controller: model.resignDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: model.joinDateFormat,
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.resignDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {

                                  }
                                },
                                message: 'Please select resign date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Contact No#',
                                hint: 'Enter Contact No#',
                                controller: model.phone,
                                inputType: TextInputType.phone,
                                onTap: () {},
                                message: 'Please enter contact number',
                              ),
                              VerticalSpacing(20),
                              MainButton(
                                  text: "Submit",
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
      viewModelBuilder: () => ApplyFnfViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
