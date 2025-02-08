import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_visits/widget/your_visits_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../models/api_response_models/List_temperature_sheet.dart';
import '../../models/api_response_models/warehouse_model.dart';

class Pharmacist_view_model extends ReactiveViewModel with AuthViewModel, ApiViewModel
{
  List<Warehousetemp> datalist = [];

  List<String> selectedOption = ['Select Status'];
  List<String> list =  [ "Select Status", 'Approved', "Rejected"];

  init(BuildContext context) async
  {

    await  temp_list(context);
    selectedOption  = List.generate(
      datalist.length,
          (index) => "Select Status",);
    notifyListeners();
  }


  temp_list(BuildContext context) async
  {
    var newsResponse = await runBusyFuture(apiService.pharmacist_list(context));
    newsResponse.when(success: (data)
    async
    {
      if ((data.datalist?.length ?? 0) > 0) {
        datalist = data.datalist;
      }
      else
      {
        Constants.customWarningSnack(context, "Not Found");
      }
    },
        failure: (error)
        {


          Constants.customErrorSnack(context, error.toString());
        });
  }

  approval(BuildContext context,int index, String record, String status) async
  {
    var newsResponse = await apiService.pharmacist_temp(context,record , status);
    newsResponse.when(success: (data) async
    {
      if (data['code'] == "200")
      {
        datalist.removeAt(index);
        Constants.customSuccessSnack( context, data['msg'] );
        notifyListeners();
      }
      else
      {
        Constants.customErrorSnack(context, data['msg']);
      }
    },
        failure: (error) {
          Constants.customErrorSnack(context, error.toString());
        }
    );
  }







  void showimage(BuildContext context, String img)
  {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismiss by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display Network Image with smaller size
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  img,
                  fit: BoxFit.fill, // Use BoxFit.contain to ensure the image stays within the given space
                  // Set a smaller width for the image
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
