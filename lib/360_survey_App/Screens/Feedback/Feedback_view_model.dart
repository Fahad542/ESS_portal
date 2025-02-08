import 'package:ess/360_survey_App/Api_services/data/network/Api_services.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/Feedbacks_taker_model.dart';
import '../../Models/Questions_model.dart';

class FeedbackViewModel extends ChangeNotifier
{
   bool isLoading=false;
   Api api=Api();
   List<FeedbackTaker> datalist=[];
   List<Question> questions=[];

   Future<void> fecthdata() async {

     isLoading = true; // Set loading state to true
     notifyListeners(); // Notify listeners to rebuild the UI

     try {
       FeedbackResponse data = await api.feedbacks();
       datalist=data.feedbackTakers;
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

   Future<void> fetchquestions() async {

     isLoading = true; // Set loading state to true
     notifyListeners(); // Notify listeners to rebuild the UI

     try {
       QuestionsResponse data = await api.questions();
       questions=data.questions;
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