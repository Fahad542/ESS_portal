import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_response_models/attendence.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/your_attandence/widget/attendence_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class YourAttendanceViewModel extends ReactiveViewModel
    with AuthViewModel, ApiViewModel {
  List<Forms> attendances = [];

  AttendenceTableData heading = AttendenceTableData(
    date: 'Date',
    checkIn: 'Check In',
    checkOut: 'Check Out',
      Attendstatus: 'attend_status',
      formetedDate: DateTime.now()
  );
  List<AttendenceTableData> data = [];

  init(BuildContext context) async {
    await getAttendanceData(context);
    attendances.toList().forEach((element) {
      var timeInputFormat = DateFormat('hh:mm a');
      var datedInputFormat = DateFormat('EE ,dd-MMM');
      DateTime inTime = DateTime.parse("2020-01-02 ${element.checkIn.toString()}");
      var checkIn = timeInputFormat.format(inTime);
      DateTime outTime = DateTime.parse("2020-01-02 ${element.checkOut.toString()}");
      var checkOut = timeInputFormat.format(outTime);
      var date = datedInputFormat.format(DateTime.parse(element.attendDate.toString()));
      var attendstatus =(element.attendStatus.toString());
      data.add(
          AttendenceTableData(
              date: date,
              checkIn: checkIn,
              checkOut: checkOut,
              Attendstatus: attendstatus,
              formetedDate: DateTime.parse(element.attendDate.toString()),
          statusColor: colorSelection(element.attendStatus.toString(),))
      );});
    notifyListeners();
  }

  Color colorSelection(String title) {
    switch (title) {
      case "Late":
        {
          return Colors.red;
          }
      case "Half Day":
        {
          return Colors.black;
        }
      case "Absent":
        {
          return Colors.orange;
        }
      case "On Time":
        {
          return Colors.green;
        }
      case "Weekend":
        {
          return AppColors.primary;
        }
      default:
        {
          return AppColors.primary;
        }
    }
  }


    getAttendanceData(
    BuildContext context,
  ) async {
    var newsResponse = await runBusyFuture(apiService.attendance(context));
    newsResponse.when(success: (data) async {
      if ((data.forms?.length ?? 0) > 0) {
        attendances = data.forms?.toList() ?? [];
      } else {
        Constants.customWarningSnack(context, "Attendence not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
