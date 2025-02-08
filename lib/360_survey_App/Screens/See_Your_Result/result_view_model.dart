import 'package:ess/360_survey_App/Models/Result_model.dart';
import 'package:flutter/cupertino.dart';

import '../../Api_services/data/network/Api_services.dart';
import '../../Models/Feedbacks_taker_model.dart';
import '../../Models/Questions_model.dart';

class ResultViewModel extends ChangeNotifier
{
  bool isLoading=false;
  Api api=Api();
  ResultModel? resultlist;
  List<Question> questions=[];

  Future<void> resultdata(String question) async {

    isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners to rebuild the UI

    try {
      ResultModel data = await api.result(question);
      resultlist=data;
      print("status: ${resultlist!.code}");
      print("msg: ${resultlist!.loginMsg}");
      print("stronglyAgree: ${resultlist!.stronglyAgree}");
      print("Agree: ${resultlist!.agree}");
      print("disagree: ${resultlist!.disAgree}");
      print("stronglydisagree: ${resultlist!.stronglyDisagree}");
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
  Future<void> resultdata1(String question) async {
    try {
      ResultModel data = await api.result(question);
      resultlist=data;
      print("status: ${resultlist!.code}");
      print("msg: ${resultlist!.loginMsg}");
      print("stronglyAgree: ${resultlist!.stronglyAgree}");
      print("Agree: ${resultlist!.agree}");
      print("disagree: ${resultlist!.disAgree}");
      print("stronglydisagree: ${resultlist!.stronglyDisagree}");

    } catch (e) {
      print(e);

    } finally {

    }
  }
  Future<void> fetchquestions() async {

    isLoading = true;
    notifyListeners();

    try {
      QuestionsResponse data = await api.questions();
      questions=data.questions;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      // Handle errors
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



}