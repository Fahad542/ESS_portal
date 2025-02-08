import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/capex_form_data.dart';
import 'package:ess/Ess_App/src/models/api_response_models/branches.dart' as br;
import 'package:ess/Ess_App/src/models/api_response_models/capex_forms.dart';
import 'package:ess/Ess_App/src/models/api_response_models/capex_item.dart' as ct;
import 'package:ess/Ess_App/src/models/api_response_models/region.dart' as Rg;
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/api_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:stacked/stacked.dart';

import '../../../configs/app_setup.locator.dart';
import '../../../models/api_response_models/Capex_model.dart';
import '../../../models/api_response_models/user.dart';
import '../../../services/local/auth_service.dart';


class GenerateCapexViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {
List<CapexModel> capexlist=[];

  init(BuildContext context) async {

    mycapex(context);

  }

  void mycapex(BuildContext context) async {


    var newresponse = await runBusyFuture(apiService.mycapex(context));
    newresponse.when(success: (data)
    {
      capexlist=data.forms;


    }, failure: (error)
    {
      Constants.customErrorSnack(context, error.toString());
    }
    );
  }



}
