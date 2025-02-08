import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_visits/widget/your_visits_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../models/api_response_models/warehouse_list_model.dart';
import '../../models/api_response_models/warehouse_model.dart';

class temperaure_listViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {

    List<Warehouselist> warehouse = [];





  init(BuildContext context) async {

    getwarehouselist(context);
    notifyListeners();
  }


  getwarehouselist(BuildContext context) async
  {
    var newsResponse = await runBusyFuture(apiService.warelist(context));
    newsResponse.when(success: (data) async
    {
      if ((data.datalist?.length ?? 0) > 0)
      {
        warehouse = data.datalist?.toList() ?? [];
        print("Warehouse: ${warehouse}");
      }
      else
      {
        Constants.customWarningSnack(context, "Warehouselist not found");
      }
    },
        failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }







}