import 'dart:convert';

import 'package:ess/360_survey_App/Models/Login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Learning_management_system/Models/Login_model.dart';

class Sharedprefrence {


  Future<void> savedata(LoginResponse responsne) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(responsne.toJson());
    prefs.setString("Login data", data);
    print("Save data in shared successfully");
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json= prefs.getString("Login data");
   if(json!=null)
     {
       LoginResponse response = LoginResponse.fromJson(jsonDecode(json));
        UserData.setUserData(response.data.username.toString(), response.data.empCode.toString());
        print("username: ${response.data.username.toString()}");
       print("code: ${response.data.empCode.toString()}");
     }
  }



  Future<void> savelmsdata(List<Lmsloginmodel>? responsne) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(responsne?.map((e) => e.toJson()).toList());
    print("save data: ${data}");
    prefs.setString("lms Login data", data );
    print("Save data in shared successfully");
  }

  Future<void> getlmsdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString("lms Login data");

    if (json != null) {
      print("data: $json");

      // Decode the JSON as a list of maps
      List<dynamic> jsonList = jsonDecode(json);
      List<Lmsloginmodel> responseList = jsonList
          .map((item) => Lmsloginmodel.fromJson(item as Map<String, dynamic>))
          .toList();

      // Use the first item if you only need one user
      if (responseList.isNotEmpty) {
        Lmsloginmodel firstUser = responseList.first;

        print("response: ${firstUser.memberName}");
        lmsUserData.lmssetUserData(
          firstUser.memberName,
          firstUser.memberId,
          firstUser.mobile,
        );
        print("lmsUserData.member_id : ${lmsUserData.member_id}");
      } else {
        print("No user data available.");
      }
    } else {
      print("No saved data found.");
    }
  }


}


class UserData {
  static String? username;
  static String? empCode;

  static void setUserData(String name, String code) {
    username = name;
    empCode = code;
  }

  static void clearUserData() {
    username = null;
    empCode = null;
  }
}



class lmsUserData {
  static String? member_name;
  static String? member_id;
  static String? mobile;


  static void lmssetUserData(String name, String code , String mobileno) {
    member_name = name;
    member_id = code;
    mobile=mobileno;
  }

  static void lmsclearUserData() {
    member_name = null;
    member_id = null;
    mobile=null;
  }
}