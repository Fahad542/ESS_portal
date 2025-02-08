import 'package:ess/360_survey_App/Models/Poll_model.dart';
import 'package:flutter/cupertino.dart';

import '../../Api_services/data/network/Api_services.dart';

class PollViewModel extends ChangeNotifier
{
  bool isLoading=false;
  Api api=Api();
  List<User> datalist=[];


  Future<void> fecthdata() async {

    isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners to rebuild the UI

    try {
      PollResponse data = await api.polls();
      datalist=data.pool;
      print("Datalist: ${datalist}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      // Handle errors
    } finally {
      isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners again to rebuild the UI
    }
  }


}