import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../local_db.dart';

class NotificationViewModel extends ReactiveViewModel with AuthViewModel {


  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
  List<Map<String, dynamic>> list = [];
  DatabaseHelper db=DatabaseHelper();

  void init(BuildContext context) async {
    fetchdata();
  }
  void fetchdata() async {
    list = await db.getlocation();
    print("list: ${list}");
    notifyListeners();
  }


}
