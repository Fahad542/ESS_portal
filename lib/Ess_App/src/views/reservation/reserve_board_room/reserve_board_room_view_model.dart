import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/reservation_form_data.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ReserveBoardRoomViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {

  List<String> boardRoams = ["Board Room 1 - Ground Floor", "Board Room 2 - 1st Floor", "Board Room 3 - 2nd Floor (Small)", "Training Hall - Ground Floor", "Board Room 4 - 2nd Floor (Large)"];
  int boardRoamSelectedIndex = 0;
  DateTime bookDateFormat = DateTime.now();
  TextEditingController employeeCode = TextEditingController();
  TextEditingController nop = TextEditingController();
  TextEditingController agenda = TextEditingController();
  TextEditingController bookDate = TextEditingController();
  TextEditingController fromTime = TextEditingController();
  TimeOfDay fromTimeFormat = TimeOfDay.now();
  TextEditingController toTime = TextEditingController();
  TextEditingController remarks = TextEditingController();


  init(BuildContext context) async {   employeeCode.text = currentUser?.userId.toString() ?? "000000";
    String? formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bookDate.text = formattedDate;
  }

  clear(){
    employeeCode.text = currentUser?.userId.toString() ?? "000000";
    nop.clear();
    agenda.clear();
    bookDateFormat = DateTime.now();
    String? formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bookDate.text = formattedDate;
    fromTime.clear();
    toTime.clear();
    remarks.clear();
    boardRoamSelectedIndex = 0;
  }

  apply(BuildContext context) async {
    if(m.Form.of(context).validate()) {
      await setLeaveApplicationsData(context);
    }
  }

  setLeaveApplicationsData(BuildContext context,) async {
    ReservationFormData formData = ReservationFormData(
      empCode: employeeCode.text,
      boardRoom: boardRoams[boardRoamSelectedIndex],
      bookDate: bookDate.text,
      fromTime: fromTime.text,
      toTime: toTime.text,
      nop: nop.text,
      agenda: agenda.text,
      remarks: remarks.text,
    );
    var newsResponse = await runBusyFuture(apiService.reserveRoom(context,formData));
    newsResponse.when(success: (data) async {
      if (data == "BoardRoom Successfully Booked") {
        clear();
        Constants.customSuccessSnack(context, "Your Application Submitted Successfully");
        NavService.allReservations();
      } else {
        Constants.customErrorSnack(context, "Your Application Not Submit, Try Again");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
