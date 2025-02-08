import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_response_models/all_reservation.dart';
import 'package:ess/Ess_App/src/models/api_response_models/leave_applications.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AllReservationsViewModel extends ReactiveViewModel
    with AuthViewModel, ApiViewModel {

  List<ReservationDatalist> reservationData = [];

  init(BuildContext context) async {
    await getAllReservationData(context);
    notifyListeners();
  }

  getAllReservationData(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getAllReservations(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0) {
        reservationData = data.datalist?.reversed.toList() ?? [];
      } else {
        Constants.customWarningSnack(context, "Leaves not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
