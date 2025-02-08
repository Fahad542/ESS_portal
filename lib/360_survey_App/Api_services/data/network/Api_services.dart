import 'dart:convert';

import 'package:ess/360_survey_App/Api_services/data/Local_services/Session.dart';
import 'package:ess/360_survey_App/Api_services/data/network/Baseapiservices.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Learning_management_system/Models/Courses.dart';
import '../../../../Learning_management_system/Models/Login_model.dart';
import '../../../../Learning_management_system/Models/Registered_courses.dart';
import '../../../Models/Feedbacks_taker_model.dart';
import '../../../Models/Login_model.dart';
import '../../../Models/Poll_model.dart';
import '../../../Models/Questions_model.dart';
import '../../../Models/Result_model.dart';
import '../../../Models/Survey_dashboard.dart';
import '../../../Models/dashboardstat1.dart';
import '../../../Models/dashboardstat1.dart';
import '../../../Models/dashboardstat1.dart';
import 'Api_url.dart';
import 'Networkapiservices.dart';

class Api {


   BaseApiServices api= NetworkApiService( );
   Future<LoginResponse> loginapi(String username, String password) async {

    dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}login.php?username=${username}&password=${password}");
    print(response);
    return response=LoginResponse.fromJson(response);
}

   Future<FeedbackResponse> feedbacks() async{
     dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}feedback_takers_list.php?emp_code=${UserData.empCode}");
     print(response);
     return response=FeedbackResponse.fromJson(response);
   }
   Future<QuestionsResponse> questions() async {
     dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}feedback_questions.php");
     print(response);
     return response=QuestionsResponse.fromJson(response);
   }
   Future<Map<String, dynamic>> submit(List<Map<String,dynamic>> data) async {

     debugPrint("Json data: ${jsonEncode(data)}", wrapWidth: 1024);
     dynamic response = await api.getPostApiResponse("https://360.premierspulse.com/scripts/submit_feedback.php", jsonEncode(data));

     print(response);
     return response;
   }
   Future<PollResponse> polls() async {
     dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}selected_pool.php?emp_code=${UserData.empCode}");
     print(response);
     return response=PollResponse.fromJson(response);
   }
   Future<ResultModel> result(String question_number) async {


     dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}get_result.php?question=${question_number}&emp_code=${UserData.empCode}");

     print(response);

     return response=ResultModel.fromJson(response['data']);
   }
   Future<SurveyDashboard> surveydashboard() async {
     dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}dashboard_stats.php?emp_code=${UserData.empCode}");
     print(response);
     return response=SurveyDashboard.fromJson(response['data']);
   }
   Future<stat1> stats1( )  async

   {
     dynamic  response = await api.getGetApiResponse("${Appurl.baseurl}dashboard_stats_category1.php?emp_code=${UserData.empCode}");
     print(response);
     return response=stat1.fromJson(response['data']);
   }



////////////////////////// Learning management system////////////////////////////////////////


  Future<CourseResponse> courses() async {
    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/courses.php");
    print(response);
    return response=CourseResponse.fromJson(response);
  }
  Future<Registered_courses> registered_courses() async {
    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/registered_courses.php?userid=${lmsUserData.member_id}");
    print("https://lms.premierspulse.com/appApis/registered_courses.php?userid=${lmsUserData.member_id}");
    print(response);
    return response=Registered_courses.fromJson(response);
  }


  Future<LmsloginResponse> lmslogin(String username, String password) async {

    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/login.php?username=${username}&pwd=${password}");
    print(response);
    return response=LmsloginResponse.fromJson(response);
  }
  Future<Map<String, dynamic>> check_course_enroll(String courseid) async {

    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/checkEnroll.php?courseid=${courseid}&userid=${lmsUserData.member_id}");
    print("https://lms.premierspulse.com/appApis/checkEnroll.php?courseid=${courseid}&userid=${lmsUserData.member_id}");
    print(response);
    return response;
  }
  Future<Map<String, dynamic>> enroll_course(String courseid) async {

    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/enroll_course.php?courseid=${courseid}&userid=${lmsUserData.member_id}");
    print("https://lms.premierspulse.com/appApis/enroll_course.php?courseid=${courseid}&userid=${lmsUserData.member_id}");
    print(response);
    return response;
  }
  Future<List<dynamic>> course_detail(String course_id) async {
    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/course_detail.php?course_id=${course_id}");
    print("https://lms.premierspulse.com/appApis/course_detail.php?course_id=${course_id}");
    //print(response);
    return response['Datalist'];
  }
  Future<Map<String, dynamic>> signup(String username, String password , String mobile  , String fullname) async {

    dynamic  response = await api.getGetApiResponse("https://lms.premierspulse.com/appApis/register.php?username=${username}&pwd=${password}&mobile=${mobile}&fullname=${fullname}");
    print(response);
    return response;
  }

  // Future<LmsloginResponse> courses() async {
  //   dynamic  response = await api.getGetApiResponse("${Appurl.lmsbaseurl}registered_courses.php?userid=2");
  //   print(response);
  //   return response=LmsloginResponse.fromJson(response);
  // }
  //https://lms.premierspulse.com/appApis/registered_courses.php?userid=2


}