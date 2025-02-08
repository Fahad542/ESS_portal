import 'dart:async';
import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:ess/Ess_App/src/models/api_response_models/dashboard.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/notification/local_notification.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/dashboard/widget/br.dart';
import 'package:ess/Ess_App/src/views/login/login_view_model.dart';
import 'package:ess/Ess_App/src/views/your_attandence/widget/attendence_data_table.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../configs/app_setup.locator.dart';
import '../../models/api_response_models/My_smart_goals.dart';
import '../../models/api_response_models/attendence.dart';
import '../../services/local/auth_service.dart';
import '../../services/local/navigation_service.dart';
import '../local_db.dart';

class DashboardViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel

{
  LoginViewModel login = LoginViewModel();
  Dashboard? dashboard;

  String currentTime = DateTime.now().toIso8601String().substring(11, 16);
  String today = DateTime.now().toIso8601String().split('T')[0];
  DatabaseHelper database=DatabaseHelper();
  AttendenceTableData heading =
  AttendenceTableData(
    date: 'Date',
    checkIn: 'Check In',
    checkOut: 'Check Out',
    Attendstatus: 'attend_status',
    formetedDate: DateTime.now(),
  );


  List<AttendenceTableData> all = [];
  List<BarChartModel> check = [];
  List<goal> Goal = [];
  List<AttendenceTableData> alldata = [];
  List<AttendenceTableData> onTimeList = [];
  List<AttendenceTableData> lateList = [];
  List<AttendenceTableData> weekendList = [];
  List<AttendenceTableData> halfDayList = [];
  List<AttendenceTableData> AbsentList = [];
  List<Forms>storeAttendanceData = [];
  String selectedTitle = "";
  DateTime? maxCheckInTime;
  DateTime? formattedMaxCheckInTime;
  String? maxCheckInFormatted;
  bool? isBirthdayShown;


  late Map<String, double> dataMap;
  String? tokens;

  void token () async {
    tokens = await FirebaseMessaging.instance.getToken();
    notifyListeners();
  }




  double targetLatitude = 0.0;
  double targetLongitude = 0.0;
  double targetDistance = 0.0;
  AuthService _authService = locator<AuthService>();
  Future<void> locations(double Latitude, double Longitude, double distatnce) async {
    if (currentUser != null) {
      Latitude = double.parse(currentUser!.att_lon.toString());
      Longitude = double.parse(currentUser!.att_lat.toString());
      distatnce = double.parse(currentUser!.radius.toString());
      notifyListeners();
    }

    print("latitude: ${targetLatitude}");
    print("Longitude: ${targetLongitude}");
    print("targetDistance: ${targetDistance}");
  }





  void showBirthdayDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.pink[50],
          child: Container(
            padding: EdgeInsets.all(20),
            width: 300,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Image.asset("assets/images/cake.png"),
                SizedBox(height: 20),
                Text(
                  ' Happy Birthday',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  ' ${authService.user!.userName} 🎉 🎂',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),
                Text(
                  'May your day be filled with love, joy, and happiness!',
                  style: TextStyle(fontSize: 16, color: Colors.pink[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink, // Button color
                    onPrimary: Colors.white, // Text color
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Let\'s Celebrate!'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  init(BuildContext context) async

  {
    WidgetsFlutterBinding.ensureInitialized();
    setBusy(true);
    token();
    pushNotificationInstant();
    login.subscribeToken(context);
    await _checkVersion(context);
    await getDashboardData(context);
    await getgoal(context);
    await getAttendanceData(context, 'All');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double lat = prefs.getDouble('lat') ?? 0.0;

    for (int i = 0; i < check.length; i++)
    {
      if (maxCheckInTime == null || check[i].checkInTime.isAfter(maxCheckInTime!))
      {
        maxCheckInTime = check[i].checkInTime;
      }
    }
    if (maxCheckInTime != null)
    {
      maxCheckInFormatted = DateFormat('HH:mm').format(maxCheckInTime!);
    }

    else {
    }

    dataMap =
    {
      "On Time": double.parse(dashboard?.totalOntime.toString() ?? "0"),
      "Late": double.parse(dashboard?.totalLates.toString() ?? "0"),
    };

    setBusy(false);

    checkbirthday(context);
    await _requestNotificationPermission(context);
  }



void checkbirthday(BuildContext context) async
{
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  if(authService.user!.dob == formattedDate)
  {
    showBirthdayDialog(context);
  }
}
  Future<void> clearCoordinates() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lat');
    await prefs.remove('long');
    await prefs.remove('radius');
    notifyListeners();
    print("Coordinates cleared.");


  }



  Future<void> requestPermissions() async {

    var status = await Permission.location.request();
    if (status.isGranted) {
      print("Location permission granted");
    } else if (status.isDenied) {
      print("Location permission denied");
    } else if (status.isPermanentlyDenied) {
      print("Location permission permanently denied");

      openAppSettings();
    }
  }






  getAttendanceData(BuildContext context, String Status) async {
    alldata.clear();
    all.clear();
    var newsResponse = await runBusyFuture(apiService.attendance(context));
    newsResponse.when(success: (dataNew) async {
      if ((dataNew.forms?.length ?? 0) > 0) {
        dataNew.forms?.forEach((element) {
          var timeInputFormat = DateFormat('hh:mm a');
          var datedInputFormat = DateFormat('EE dd/MM');
          var day = DateFormat('EE');
          var attendstatus = element.attendStatus.toString();
          print("Attendance status: $attendstatus");
          DateTime inTime = DateTime.parse("2020-01-02 ${element.checkIn.toString()}");
          var checkIn = timeInputFormat.format(inTime);
          DateTime outTime = DateTime.parse("2020-01-02 ${element.checkOut.toString()}");
          var checkOut = timeInputFormat.format(outTime);
          var date = datedInputFormat.format(DateTime.parse(element.attendDate.toString()));
          var days = day.format(DateTime.parse(element.attendDate.toString()));
          all.add(

              AttendenceTableData(
                day: days,
            date: date,
            checkIn: checkIn,
            checkOut: checkOut,
            Attendstatus: attendstatus,
            formetedDate: DateTime.parse(element.attendDate.toString()),
            statusColor: colorSelection(element.attendStatus.toString()),)

          );

          alldata.add(
              AttendenceTableData(
            date: date,
            checkIn: checkIn,
            checkOut: checkOut,
            Attendstatus: attendstatus,
            formetedDate: DateTime.parse(element.attendDate.toString()),
            statusColor: colorSelection(element.attendStatus.toString()),
          )
          );


          if(element.attendStatus=="On Time" || element.attendStatus=="Late") {
            if (check.length < 7) {
              final DateTime checkInTime = DateFormat('HH:mm').parse(checkIn);

              check.add(BarChartModel(day: date, checkInTime: checkInTime, attendstatus: element.attendStatus!));
            }
          }
        });
      } else {
        Constants.customWarningSnack(context, "Attendance not found");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }

  void filterListsByStatus(BuildContext context, String status)
  {
    setBusy(true);
    alldata.clear();

    if (status.trim() == "All") {
      for (int i = 0; i < all.length; i++)
      {
        alldata.add(AttendenceTableData(
            date: all[i].date,
            checkIn: all[i].checkIn,
            checkOut: all[i].checkOut,
            Attendstatus: all[i].Attendstatus,
            formetedDate: DateTime.now(),
            statusColor: colorSelection(all[i].Attendstatus.toString(),
            ))
        );
      }
    } else
    {
      for (int i = 0; i < all.length; i++)
      {
        if (all[i].Attendstatus == "${status}")
        {
          alldata.add
            (
              AttendenceTableData(
              date: all[i].date,
              checkIn: all[i].checkIn,
              checkOut: all[i].checkOut,
              Attendstatus: all[i].Attendstatus,
              formetedDate: DateTime.now(),
              statusColor: colorSelection(
                all[i].Attendstatus.toString(),
              )
              )
          );
        }
      }
      print("${alldata.length}");
    }
    setBusy(false);
  }

  Color colorSelection(String title)
  {
    switch (title)
    {
      case "Late":
        {
          return Colors.red;
        }
      case "Half Day":
        {
          return Colors.purple;
        }

      case "Absent":
        {
          return Colors.orange;
        }
      case "On Time":
        {
          return Colors.green;
        }

      case "Weekend":
        {
          return AppColors.primary;
        }

      default:
        {
          return AppColors.primary;
        }
    }
  }

  Future<void> getCoordinates(BuildContext context) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var newsResponse = await runBusyFuture(apiService.getcordinantes());

    newsResponse.when(success: (data)
    async
    {
      if (data != null) {
        double lat = prefs.getDouble('lat') ?? 0.0;
        double long = prefs.getDouble('long') ?? 0.0;
        double radius = prefs.getDouble('radius') ?? 0.0;
        String userId = prefs.getString('userid') ?? '';

        double? attLat;
        if (data['att_lat'] is String) {
          attLat = double.tryParse(data['att_lat']);
        } else if (data['att_lat'] is num) {
          attLat = data['att_lat'].toDouble();
        }

        double? attLon;
        if (data['att_lon'] is String) {
          attLon = double.tryParse(data['att_lon']);
        } else if (data['att_lon'] is num) {
          attLon = data['att_lon'].toDouble();
        }

        double? attradius;
        if (data['radius'] is String) {
          attradius = double.tryParse(data['radius']);
        } else if (data['radius'] is num)
        {
          attradius = data['radius'].toDouble();
        }


        bool isLatEqual = lat == attLat;
        bool isLonEqual = long == attLon;
        bool isRadiusEqual = radius == attradius;
        bool checkin = await FlutterBackgroundService().isServiceRunning();
        if (isLatEqual && isLonEqual && isRadiusEqual && checkin ) {
          print("All values are equal.");
        } else

        {
          FlutterBackgroundService().sendData({"action": "stopService"});
          SharedPreferences sp = await SharedPreferences.getInstance();
          //await sp.clear();
          Scaffold.of(context).closeDrawer();
          authService.user = null;
          Navigator.pop(context);
          authService.logout();
          print(authService.user);
          String message = "Kindly restart your App. ";
          NavService.appmenu();
          Constants.customSuccessSnack(context, "Please restart your app. your location has been changed ");
          print("Values are not equal:");
          if (!isLatEqual) print("Latitude does not match.");
          if (!isLonEqual) print("Longitude does not match.");
          if (!isRadiusEqual) print("Radius does not match.");

        }
      }

      print("data: ${data}");

    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }


  getDashboardData(BuildContext context)
  async
  {
    var newsResponse = await runBusyFuture(apiService.dashboard(context));
    newsResponse.when(success: (data) async {
      if (data.email != null) {
        dashboard = data;
      } else {
        Constants.customWarningSnack(context, data.loginMsg.toString());
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
  getgoal(BuildContext context,) async {
    var newsResponse = await runBusyFuture(apiService.mygoal(context));
    newsResponse.when(success: (data) async {
      Goal = data.approvalListvisit.toList();

    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }

  Future<void> _checkVersion(BuildContext context) async
  {
    try {
      var status = await InAppUpdate.checkForUpdate();
      if (status.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      } else {

      }
    }
    catch (e) {
      print(e);
    }
  }

  void pushNotificationInstant() async
  {
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        print("New Notification Navigator");
      },
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null)
    {
      String? type = initialMessage.data['type'];
      if (type == "final_advance") {
        NavService.Final_advance();
      } else if (type == "attendence") {
        NavService.yourAttendance();
      }
    }
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
        print("FirebaseMessaging.onMessage.listen");
        if (     message.notification != null    )
        {
          print(message.notification!.title);
          print(message.notification!.body);
          LocalNotificationService.createAndDisplayNotification(message);
          if (  message.data.containsKey('type')  )
          {

            String? type = message.data['type'];
            if (type == "final_advance") {
              NavService.Final_advance();
            } else if (type == "attendence") {
              NavService.yourAttendance();
            } else {
              print("Unknown notification type: $type");
            }
            
          }

          else {
            print("No type key in notification data");
          }
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message)
      {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data");
          if (message.data.containsKey('type'))
          {
            String? type = message.data['type'];

            if (type == "final_advance")
            {
              NavService.Final_advance();
            }

            else if (type == "attendence")
            {
              NavService.yourAttendance();
            }

            else
            {
              print("Unknown notification type: $type");
            }

          }
          else
          {
            print("No type key in notification data");
          }
        }
      },
    );
  }


  Future<void> _requestNotificationPermission(BuildContext context) async
  {
    PermissionStatus status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied)
    {
      bool userAccepted = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enable Notifications'),
            content: Text(
                'To stay updated with the latest information, please enable notifications in the app settings.'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
      if (userAccepted)
      {
        await openAppSettings();
      }
    }
  }

  void getLocation( double attLat, double attLon, double distancce )
  {
    if (currentUser != null)
    {
      attLat = double.tryParse(currentUser!.att_lat.toString()) ?? 0.0;
      attLon = double.tryParse(currentUser!.att_lon.toString()) ?? 0.0;
      distancce = double.tryParse(currentUser!.radius.toString()) ?? 0.0;
      print("Longitude: $attLon");
      print("Latitude: $attLat");
      print("Distance: $distancce");
      notifyListeners();
    }
    else
    {
      print("Current User is null");
    }
  }

  updatenumber(BuildContext context, String number) async {
    try {
      var newsResponse = await runBusyFuture(apiService.changephonenumber(context, number));

      newsResponse.when(
        success: (data) {

          Constants.customSuccessSnack(context, data ?? 'Number Updated Successfully');
        },
        failure: (error) {
          // If there's a failure, show the error message
          Constants.customErrorSnack(context, error?.toString() ?? 'An error occurred');
        },
      );
    } catch (error) {
      // If an error occurs outside of the response, show a generic error
      Constants.customErrorSnack(context, error.toString());
    }
  }




}