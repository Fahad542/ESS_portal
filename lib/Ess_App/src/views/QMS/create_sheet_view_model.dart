import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_visits/widget/your_visits_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../models/api_response_models/warehouse_model.dart';

class CreateSheetViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel
{
  List<Warehouse> warehouse = [];
  TextEditingController branchcontroller=TextEditingController();
  TextEditingController thermo_no=TextEditingController();
  TextEditingController warehousecontroller=TextEditingController();
  TextEditingController roomcontroller=TextEditingController();
  TextEditingController date=TextEditingController();
  List<VisitsTableData> data = [];
  String selectedwarehouse='';

  String get currentMonthYear
  {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM');
    return formatter.format(now);
  }


  init(BuildContext context) async
  {
    print(currentMonthYear);
    branchcontroller.text = currentUser!.brcode!;
    date.text =currentMonthYear;
    getwarehouse(context);
    notifyListeners();
  }


  getwarehouse(BuildContext context,) async

  {
    var newsResponse = await runBusyFuture(apiService.getwarehouse(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0)
      {
        warehouse = data.datalist?.toList() ?? [];
        print("Warehouse: ${warehouse}");
      }
      else
      {
        Constants.customWarningSnack(context, "WareHouse not found");
      }
      },
        failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }



  validate(BuildContext context)
  {
    if  (selectedwarehouse.isNotEmpty && roomcontroller.text.isNotEmpty && thermo_no.text.isNotEmpty)
      {
        sheet(context);
      }
    else
      {
        Constants.customWarningSnack(context, "Please Enter all feilds");
      }
  }


  sheet(BuildContext context,) async
  {
    var newsResponse = await runBusyFuture(apiService.createsheet(context,selectedwarehouse,roomcontroller.text,date.text, thermo_no.text));
    newsResponse.when(success: (data)
    async
    {
      if(data['code'] =='200')
        {
          NavService.tempurature_list_view();
          Constants.customSuccessSnack(context, data['msg']);
        }
        else
        {
        Constants.customErrorSnack(context, data['msg']);
        }
    },
        failure: (error)
        {
      Constants.customErrorSnack(context, error.toString());
        });
  }
}

