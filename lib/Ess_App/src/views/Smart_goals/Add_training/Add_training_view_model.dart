import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/traning_model.dart';
import '../../../services/remote/base/api_view_model.dart';


class traininglviewmodel extends ReactiveViewModel  with AuthViewModel, ApiViewModel
{
  List<Training> traininglist=[];
  TextEditingController training=TextEditingController();
  String? selectedValue;

  init(BuildContext context) async {
    await gettraining(context);
    notifyListeners();
  }
clear(){
  selectedValue='';
  training.clear();
}
  gettraining(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.traininglist(context));
    newsResponse.when(success: (data) async {
      if(data.datalist.length >0) {
        traininglist = data.datalist.toList();
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
  summit(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.add_traning(context,selectedValue.toString(),training.text));
    newsResponse.when(success: (data) async {
      if( data['status']=='200' && data['status_message'] == "Training Successfully Added" ) {
        clear();
        NavService.training_view();
        Constants.customSuccessSnack(context, data['status_message']);
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}