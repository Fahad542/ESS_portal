import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_response_models/leave_applications.dart';
import 'package:ess/Ess_App/src/models/api_response_models/visits.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_leave_aplications/widget/leave_aplications_data_table.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_visits/widget/your_visits_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class VisitsViewModel extends ReactiveViewModel
    with AuthViewModel, ApiViewModel {
  List<Datalist> visits = [];

  VisitsTableData heading = VisitsTableData(location: "Location",
      reason: "Reason",
      approvedBy: "Approved By",
      appliedDate: "Applied Date",
      visitsDate: "Visits On",
      statusColor: Colors.black,
      status: "Status");
  List<VisitsTableData> data = [];

  init(BuildContext context) async {
    await getVisitsData(context);
    visits.reversed.toList().forEach(
            (element) {
      String _visitStartDate = element.visitDaterange?.replaceRange(2, 26, "") ?? "";
      String _visitEndDate = element.visitDaterange?.replaceRange(0, 15, "") ?? "";
      String visitDate = "$_visitStartDate To $_visitEndDate";
      String visitEndDate = _visitEndDate.replaceRange(2, 11, "");
      bool isSingleDayVisit = (_visitStartDate == visitEndDate) ? true : false;
      data.add(
          VisitsTableData(
          location: element.visitLocation.toString(),
          reason: element.visitReason.toString(),
          approvedBy: element.approvedBy.toString(),
          appliedDate: element.formFillDate.toString(),
          visitsDate: isSingleDayVisit ? _visitEndDate : visitDate,
          statusColor: colorSelection(element.formStatus.toString().toLowerCase()),
          status: element.formStatus.toString())
      );
    });
    notifyListeners();
  }

  Color colorSelection(String title) {
    switch (title) {
      case "approved":
        {
          return Colors.green;
        }
      case "pending":
        {
          return Colors.orange;
        }
      case "rejected":
        {
          return Colors.red;
        }
      default:
        {
          return AppColors.primary;
        }
    }
  }

  getVisitsData(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.getVisits(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0) {
        visits = data.datalist?.toList() ?? [];
      } else {
        Constants.customWarningSnack(context, "Visit not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
