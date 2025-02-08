import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/input_field.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/capex/apply_capex/apply_capex_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ApplyCapexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplyCapexViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Apply Capex",
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
                              SecondInputField(
                                label: 'Employee Code',
                                hint: 'Enter Employee Code',
                                controller: model.employeeCode,
                                inputType: TextInputType.text,
                                onTap: () {},
                                message: 'Please enter employee code',
                              ),
                              VerticalSpacing(20),
                              CustomDropDown(
                                label: "Capex For",
                                value: model.capexForList[model.capexForIndex],
                                items: model.capexForList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.capexForIndex = model.capexForList.indexWhere((element) => element == newValue);
                                  model.notifyListeners();
                                },
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
                                label: 'Department',
                                hint: 'Enter Department',
                                controller: model.department,
                                inputType: TextInputType.text,
                                onTap: () {},
                                message: 'Please enter department',
                              ),
                              VerticalSpacing(20),
                              CustomDropDown(
                                label: "Items",
                                value: model.items[model.selectedItemIndex].itemName ?? "",
                                items: model.items.map((var items) {
                                  return DropdownMenuItem(
                                    value: items.itemName,
                                    child: Text(items.itemName ?? ""),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.selectedItemIndex = model.items.indexWhere((element) => element.itemName == newValue);
                                  model.notifyListeners();
                                },
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Quantity',
                                hint: 'Enter Quantity',
                                controller: model.qty,
                                inputType: TextInputType.number,
                                onTap: () {},
                                message: 'Please enter qunatity',
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
      viewModelBuilder: () => ApplyCapexViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
