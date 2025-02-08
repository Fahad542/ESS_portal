import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_response_models/leave_applications.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_leave_aplications/widget/leave_aplications_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class LeaveApplicationsViewModel extends ReactiveViewModel
    with AuthViewModel, ApiViewModel {

  List<LeaveForms> leaves = [];

  LeaveApplicationsTableData heading = LeaveApplicationsTableData(
      appliedDate: "Date",
      totalDays: "Total Days",
      sick: "Sick",
      casual: "Casual",
      annual: "Annual",
      startDate: "Start At",
      endDate: "End At");
  List<LeaveApplicationsTableData> data = [];


  init(BuildContext context) async {
    await getLeaveApplicationsData(context);
    leaves.reversed.toList().forEach((element) {
      var datedInputFormat = DateFormat('EE dd/MM');
      String leaveStartDate = element.leaveDaterange?.replaceRange(9, 23, "") ?? "";
      String leaveEndDate = element.leaveDaterange?.replaceRange(0, 14, "") ?? "";
      DateTime ad = DateTime.parse("${element.date.toString()} 13:27:00");
      String appliedDate = datedInputFormat.format(ad);

      int sick = int.parse(((element.sickLeave?.length ?? 0) > 0)
          ? element.sickLeave.toString()
          : "0");
      int casual = int.parse(((element.casualLeave?.length ?? 0) > 0)
          ? element.casualLeave.toString()
          : "0");
      int annual = int.parse(((element.annualLeave?.length ?? 0) > 0)
          ? element.annualLeave.toString()
          : "0");

      data.add(LeaveApplicationsTableData(
          appliedDate: appliedDate,
          totalDays: (sick + casual + annual),
          sick: sick,
          casual: casual,
          annual: annual,
          startDate: leaveStartDate,
          endDate: leaveEndDate,
          statusColor: colorSelection(element.statusType.toString()),
          status: element.statusType.toString()));
    });
    notifyListeners();
  }

  Color colorSelection(String title) {
    switch (title) {
      case "Approved":
        {
          return Colors.green;
        }
      case "Manager Approval Pending":
        {
          return Colors.orange;
        }
      case "Rejected":
        {
          return Colors.red;
        }
      default:
        {
          return AppColors.primary;
        }
    }
  }

  getLeaveApplicationsData(
    BuildContext context,
  ) async {
    var newsResponse =
        await runBusyFuture(apiService.getLeaveApplications(context));
    newsResponse.when(success: (data) async {
      if ((data.forms?.length ?? 0) > 0) {
        leaves = data.forms?.toList() ?? [];
      } else {
        Constants.customWarningSnack(context, "Leaves not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
