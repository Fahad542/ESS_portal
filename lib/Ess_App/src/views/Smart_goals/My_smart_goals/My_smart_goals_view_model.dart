import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../base/utils/constants.dart';
import '../../../services/local/base/auth_view_model.dart';
import '../../../services/remote/base/api_view_model.dart';
import '../Widgets/table.dart';

class MYsmartgoalviewmodel extends ReactiveViewModel  with AuthViewModel, ApiViewModel
{

  Mysmartgoaldata headings =Mysmartgoaldata(Goal_Name: 'Goal Name', Goal_Detail: "Goal Detail", Measures: "Measures", Weightage: 'Weightage', Your_Score: "Your_Score", Manager_Score: 'Manager Score');
List<Mysmartgoaldata> goaldata=[];

  init(BuildContext context) async {
await getgoal(context);
    notifyListeners();
  }

  getgoal(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.mygoal(context));
    newsResponse.when(success: (data) async {
     var goals= data.approvalListvisit.map((e) => Mysmartgoaldata(Goal_Name: e.goal_name, Goal_Detail: e.goal_detail, Measures: e.measures,
          Weightage: e.weightage,
          Your_Score: e.goal_name,
          Manager_Score: e.goal_name)).toList();
     goaldata.addAll(goals);

    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}