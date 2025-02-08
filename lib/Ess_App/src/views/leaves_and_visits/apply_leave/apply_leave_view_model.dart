import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/leave_form_data.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';

import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ApplyLeaveViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel

{
  final String? date;
  ApplyLeaveViewModel(this.date);

  List<String> leaveTypes = ["sick", "annual", "casual"];
  int typeSelectedIndex = 0;
  DateTime toDateFormat = DateTime.now();
  TextEditingController employeeCode = TextEditingController();
  TextEditingController employeePosition = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController leaveReason = TextEditingController();


  init(BuildContext context) async {
    employeeCode.text = currentUser?.userId.toString() ?? "000000";
    String? formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
    fromDate.text = formattedDate;
    toDate.text = formattedDate;
  }

  clear()
  {
    employeePosition.clear();
    fromDate.clear();
    toDate.clear();
    leaveReason.clear();
    typeSelectedIndex = 0;
  }

  apply(BuildContext context) async {
    if(m.Form.of(context).validate()) {
      await setLeaveApplicationsData(context);
    }
  }

  setLeaveApplicationsData(BuildContext context,) async
  {
    LeaveFormData formData = LeaveFormData(
      fromDate: fromDate.text,
      toDate: toDate.text,
      leaveType: leaveTypes[typeSelectedIndex],
      empCode: employeeCode.text,
      empPosition: employeePosition.text,
      leaveReason: leaveReason.text
    );
    var newsResponse = await runBusyFuture(apiService.applyLeave(context,formData));
    newsResponse.when(success: (data) async
    {
      if (data["code"] == 200)
      {
        clear();
        Constants.customSuccessSnack(context,data['Message']);
        NavService.leaveApplications();
      }
      else if(data['code'] ==400)
        {
          Constants.customSuccessSnack(context,data['Message']);
        }
      else
        {
        Constants.customErrorSnack(context, "Your Application Not Submit, Try Again");
        }
      }, failure: (error)
    {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
