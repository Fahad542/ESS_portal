import 'package:ess/360_survey_App/Models/Poll_model.dart';
import 'package:flutter/cupertino.dart';

import '../../Api_services/data/network/Api_services.dart';
import '../../Models/Survey_dashboard.dart';
import '../../Models/dashboardstat1.dart';

class SurveyDashboardViewModel extends ChangeNotifier
{
  bool isLoading=false;
  Api api=Api();
  SurveyDashboard? datalist;
  stat1? stats1;


  Future<void> status() async {

    isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners to rebuild the UI

    try {
      SurveyDashboard data = await api.surveydashboard();
      datalist=data;
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

  Future<void> status1data() async {

    isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners to rebuild the UI

    try {
      stat1 data = await api.stats1();
      stats1=data;
      print("Datalist: ${stats1}");
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