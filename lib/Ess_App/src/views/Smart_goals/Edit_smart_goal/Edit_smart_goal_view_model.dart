import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/Batch_model.dart';
import '../../../models/api_response_models/traning_model.dart';
import '../../../services/remote/base/api_view_model.dart';

class Editsmartgoalviewmodel extends ReactiveViewModel  with AuthViewModel, ApiViewModel
{
String weightage='';
String sum='';
var id;
String? selectedValue;

List<Item> batch=[];
List<String> dropdownItems = [];
//TextEditingController batch=TextEditingController();
TextEditingController smart_goal=TextEditingController();
TextEditingController goal_detail=TextEditingController();
TextEditingController measures=TextEditingController();
TextEditingController weightageinpercentage=TextEditingController();

  init(BuildContext context) async {
    await checktraining(context);
    await gettraining(context);
    await getbatchlist(context);
    notifyListeners();
  }


  checktraining(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.check_employee_training(context));
    newsResponse.when(success: (data) async {
      if( data['status']=='200' && data['training_count']==0) {
           {
             NavService.addtraning();
           }

        notifyListeners();


      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }




  gettraining(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.fetch_employee_goal_weightage(context));
    newsResponse.when(success: (data) async {
     if( data['status']=='200' ) {
       weightage=data['totalWeightage'];

       notifyListeners();


     }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }

getbatchlist(BuildContext context,) async {
  var newsResponse = await runBusyFuture(apiService.fetchbatchlist(context));
  newsResponse.when(success: (data) async {
if(data.datalist.length >0) {

  batch=data.datalist.toList();
}
  }, failure: (error) {
    Constants.customErrorSnack(context, error.toString());
  });
}


addgoal(BuildContext context) async {
  var newsResponse = await runBusyFuture(apiService.add_goal(context,smart_goal.text,goal_detail.text,measures.text,weightageinpercentage.text,selectedValue.toString()));
  newsResponse.when(success: (data) async {
    if( data['status']=='200') {
      NavService.smartgoal();
      Constants.customSuccessSnack(context, data['status_message']);
    }
    else {
      Constants.customSuccessSnack(context, data['status_message']);
    }
  }, failure: (error) {
    Constants.customErrorSnack(context, error.toString());
  });
}



}