import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../../base/utils/constants.dart';
import '../../../../models/api_response_models/Training_model.dart';
import '../../../../services/remote/base/api_view_model.dart';

class mytraininglviewmodel extends ReactiveViewModel  with AuthViewModel, ApiViewModel
{
  List<Trainings> traininglist=[];
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
    var newsResponse = await runBusyFuture(apiService.training_view(context));
    newsResponse.when(success: (data) async {
      if(data.forms.length >0) {
        traininglist = data.forms.toList();
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }

}