import 'dart:async';
import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'local/local_db.dart';

class LoginViewModel extends ReactiveViewModel with ApiViewModel, AuthViewModel {

  bool isSignInButtonEnable = false;
  bool isShowPassword = false;
  bool isdevicesupport=false;
  bool isSwitched = false;
  bool? checktabledata;
  Map<String, dynamic> data={};
  List<BiometricType>? availablebiometric;
  final dbHelper = DatabaseHelper();
  final LocalAuthentication? auth =LocalAuthentication();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  double targetLatitude = 0.0;
  double targetLongitude = 0.0;
  double targetDistance = 0.0;

  Future<void> checktable () async {
    checktabledata = await  dbHelper.checkTable();
    print("table data: ${checktabledata}");
    if(checktabledata == true)
    {
      await getdata();
    }
      notifyListeners();
  }
  Future<void> getdata() async {

    data = (await dbHelper.getUser())!;

    print("data: ${data['email']}");
    notifyListeners();
  }

  void init(BuildContext context)
  {
    checktable();
  }

  void saveAdvFinAppToSharedPreferences(String advFinAppValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('AdvFinApp', advFinAppValue);
  }
  LogIn(BuildContext context) async {
    var data1 = ( await dbHelper.getUser())!;
    print('User data retrieved: $data1');

    var newsResponse = await runBusyFuture(apiService.login(context, data1['email'], data1['password']));

    newsResponse.when(success: (data) async {
      if (data.email != null) {
        print('Login successful for user: ${data.userName}');
        authService.user = data;

        subscribeToken(context);
        NavService.dashboard();
        if (data.att_lat != null && data.att_lon != null)
        {
          print('Data sent to background service: lat: ${data.att_lat}, long: ${data.att_lon}');
        }
        else
        {
          print('Invalid location data: $data');
        }

        Constants.customSuccessSnack(context, "Welcome Back ${data.userName}");
      } else {
        print('Login failed: ${data.loginMsg}');
        Constants.customErrorSnack(context, data.loginMsg.toString());
      }
    }, failure: (error) {
      print('Login error: $error');
      Constants.customErrorSnack(context, error.toString());
    });
  }
  getcordinantes(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getcordinantes());
    newsResponse.when(success: (data) async {
      if(data !=null) {
        FlutterBackgroundService().sendData(
            {
              'lat': data['att_lat'],
              'long': data['att_lon'],
              'radius': data['radius'],
              'userid': currentUser!.userId.toString(),
              'timestamp': DateTime.now().millisecondsSinceEpoch
            });
       await _updatePreferences(data);

            }

      print("data: ${data}");

    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
  Future<void> _updatePreferences(Map<String, dynamic> event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lat', double.tryParse(event['att_lat'].toString()  )  ??  0.0 )  ;
    await prefs.setDouble('long', double.tryParse(event['att_lon'].toString()  ) ?? 0.0 ) ;
    await prefs.setDouble('radius', double.tryParse(event['radius'].toString()  ) ?? 0.0 ) ;

    print("Save data in shared successfully");
  }
  onLogIn(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.login(context, email.value.text.trim(), password.value.text.trim()));
    newsResponse.when(success: (data) async {
      if (data.email != null) {
        authService.user = data;
        if (data.att_lat != null && data.att_lon != null) {

          print('Data sent to background service: lat: ${data.att_lat}, long: ${data.att_lon}');
        } else {
          print('Invalid location data: $data');
        }
        subscribeToken(context);
        if(isSwitched == true)
          {
            await dbHelper.insertUser(email.value.text.trim(), password.value.text.trim());
          }
        bool checkin = await FlutterBackgroundService().isServiceRunning();

        email.clear();
        password.clear();
        NavService.dashboard();



        Constants.customSuccessSnack(context, "Welcome Back ${data.userName}");
      } else {
        Constants.customErrorSnack(context, data.loginMsg.toString());
      }}, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }

  Future<void> saveLocation(String latitude, String longitude, String distance, String userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String locationData = '{"latitude": $latitude, "longitude": $longitude, "distance": $distance , "userid": $userid} ';
    await prefs.setString('location', locationData);
    print("Location save Successfully");
  }
  Future<void> _requestPermissions() async {

    var status = await Permission.location.request();
    if (status.isGranted) {
      print("Location permission granted");
    } else if (status.isDenied) {
      print("Location permission denied");
    } else if (status.isPermanentlyDenied)
    {
      print("Location permission permanently denied");
      openAppSettings();
    }

  }
  subscribeToken(BuildContext context) async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token: ${token}");
    var newsResponse = await runBusyFuture(apiService.tokenSubscribe(context, token ?? ""));
    newsResponse.when(success: (data) async {
      print("data: ${data}");

    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
  checkButtonValidate(BuildContext context) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.value.text)) {
      if (password.value.text.length > 3) {
        isSignInButtonEnable = true;
        notifyListeners();
      } else {
        isSignInButtonEnable = false;
        notifyListeners();
      }
    } else {
      isSignInButtonEnable = false;
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];

}
