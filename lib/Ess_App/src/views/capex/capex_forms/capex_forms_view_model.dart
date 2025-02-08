import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_response_models/capex_forms.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CapexFormsViewModel extends ReactiveViewModel
    with AuthViewModel, ApiViewModel {
  List<Datalist> capexForms = [];

  init(BuildContext context) async {
    await getCapexFormsData(context);
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

  getCapexFormsData(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getCapexForms(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0) {
        capexForms = data.datalist?.reversed.toList() ?? [];
      } else {
        Constants.customWarningSnack(context, "Capex not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
