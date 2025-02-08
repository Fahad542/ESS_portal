import 'package:ess/360_survey_App/Models/Poll_model.dart';
import 'package:ess/Learning_management_system/Models/Courses.dart';
import 'package:flutter/cupertino.dart';

import '../../../360_survey_App/Api_services/data/network/Api_services.dart';



class LmsDashboardViewModel extends ChangeNotifier
{
  bool isLoading=false;
  Api api=Api();
  List<Course> datalist=[];



  Future<void> courses() async {

    isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners to rebuild the UI

    try {
      CourseResponse data = await api.courses();
      datalist=data.dataList;
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