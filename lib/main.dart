import 'dart:convert';
import 'package:ess/Ess_App/src/services/local/auth_service.dart';
import 'package:ess/Ess_App/src/services/remote/api_service.dart';
import 'package:ess/Ess_App/src/services/remote/notification/local_notification.dart';
import 'package:ess/Ess_App/src/views/dashboard/dashboard_view_model.dart';
import 'package:ess/Ess_App/src/views/local_db.dart';
import 'package:flutter/material.dart';
import 'package:ess/Ess_App/src/app/app_view.dart';
import 'package:ess/Ess_App/src/configs/app_setup.locator.dart';
import 'package:ess/Ess_App/src/services/local/flavor_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


DateTime? lastApiCallTime;
DatabaseHelper databse=DatabaseHelper();

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
Future<void> resetBirthdayFlag() async {

  final prefs = await SharedPreferences.getInstance();
  DateTime now = DateTime.now();
  if (now.month == 1 && now.day == 1) {
    await prefs.remove('birthday');
  }

}
ApiService api = ApiService();
DashboardViewModel dashboard =DashboardViewModel();
DateTime?  lastLocationUpdateTime;

DatabaseHelper database = DatabaseHelper();

String? userid;
final currentTimes = DateTime.now();
String currentTime = DateTime.now().toIso8601String().substring(11, 16);
String today = DateTime.now().toIso8601String().split('T')[0];
DateTime? lastAttendanceCheckTime;

void main() async

{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isDialogShown');
  //resetBirthdayFlag();
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  //_requestPermissions();
  LocalNotificationService.initialize();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  AuthService.prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations
    (
      [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
      ]
    );
  final package = await PackageInfo.fromPlatform( );
  setupLocator( );
  FlavorService.init( package );
  String? token = await FirebaseMessaging.instance.getToken( );
  print('Firebase Token: $token');
  // FlutterBackgroundService.initialize(start);
  runApp(AppView());
}






@pragma('vm:entry-point')
Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  Future<void> printcordinantes() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double lat = prefs.getDouble('lat') ?? 0.0;
    double long = prefs.getDouble('long') ?? 0.0;
    double radius = prefs.getDouble('radius') ?? 0.0;
    String userId = prefs.getString('userid') ?? '';

    print(" Api latitude: ${lat}, longitude : ${long} , radius: ${radius}");
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();

  double lat = prefs.getDouble('lat') ?? 0.0;
  double long = prefs.getDouble('long') ?? 0.0;
  double radius = prefs.getDouble('radius') ?? 0.0;
  String userId = prefs.getString('userid') ?? '';

  final settings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    intervalDuration: Duration(seconds: 20),
    distanceFilter: 0,
  );

  await Geolocator.getPositionStream(
      locationSettings: settings).listen
    (
          (pos) async


  {
    print("-------------------------");
    await Future.delayed(Duration(seconds: 2));
    print("lat:${pos.latitude} long:${pos.longitude}");
    print("target_lat:${lat} target_long:${long} distance:${radius}");
    await _checkAttendance(pos.latitude, pos.longitude, lat, long, radius, userId);
  }


  );





  FlutterBackgroundService().onDataReceived.listen((event) async {

    print("Received event: $event");

    if (event is Map) {
      if (event!.containsKey('lat')) {
        await _updatePreferences(event!);
        await printcordinantes();

        double lat = prefs.getDouble('lat') ?? 0.0;
        double long = prefs.getDouble('long') ?? 0.0;
        double radius = prefs.getDouble('radius') ?? 0.0;
        String userId = prefs.getString('userid') ?? '';

        final settings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          intervalDuration: Duration(seconds: 20),
          distanceFilter: 0,
        );

        await Geolocator.getPositionStream(locationSettings: settings).listen((pos) async {
          print("-------------------------");
          await Future.delayed(Duration(seconds: 2));
          print("lat:${pos.latitude} long:${pos.longitude}");
          print("target_lat:${lat} target_long:${long} distance:${radius}");
          await _checkAttendance(pos.latitude, pos.longitude, lat, long, radius, userId);
          print("event: ${event}");
        });


      } else if (event!.containsKey('action') && event['action'] == 'stopService') {
        FlutterBackgroundService().stopBackgroundService();
        print("Background service stopped");
      }

    } else {
      print("Received event is null or not a Map: $event"); // Log the received event
    }
  }
  );
}
Future<void> _checkAttendance(double latitude,
    double longitude,
    double targetLat,
    double targetLong,
    double distance,
    String userId
    )
async
{
  double distanceInMeters = Geolocator.distanceBetween(
    targetLat,
    targetLong,
    latitude,
    longitude,
  );
  bool hasCheckedIn = await database.hasCheckedIn(DateTime.now().toIso8601String().split('T')[0]);
  if (!hasCheckedIn)
  {
    if (distanceInMeters <= distance)
    {
      if (!hasCheckedIn)
      {
        await getAttendance(latitude.toString(), longitude.toString(), userId,targetLat.toString(),targetLong.toString());
        print("Attendance marked at distance: $distanceInMeters meters");
        lastApiCallTime = DateTime.now(); // Update the last API call time
      }
    }
    else
    {
      print("Attendance not marked, too far. Distance: $distanceInMeters meters, Allowed Distance: $distance meters");
    }
  } else
  {
    print("Attendance already marked for today.");
  }
}


Future<void> getAttendance(String latitude, String longitude, String userid, String targetlat, String targetlong) async {
  try {
    final response = await http.get(
      Uri.parse('https://premierspulse.com/ess/scripts/mark_attendance.php?code=${userid}&lat=${latitude}&lon=${longitude}&time=${DateTime.now().toIso8601String().substring(11, 16)}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data['data']['code'] != '200') {
        bool hasCheckedIn = await database.hasCheckedIn(DateTime.now().toIso8601String().split('T')[0]);
        if (!hasCheckedIn) {
          await database.insercheckin(currentTime, targetlat, targetlong,
              DateTime.now().toIso8601String().split('T')[0],
              DateTime.now().toIso8601String().substring(11, 16), latitude,longitude);
          print("Save data in local sucessfully");
        }
        else
          {
            print("Attendannce has been marked");
          }
        print("Save data in firebabse sucessfully");
        lastApiCallTime = currentTimes;
        print("Attendance data: ${data['data']}");
      }
      else {
        print("Attendance is already marked");
      }
    } else {

      print("Failed to fetch attendance: ${response.statusCode}");
    }
  }
  catch (e)
  {
    print("Error fetching attendance: $e");
  }
}

Future<void> _updatePreferences(Map<String, dynamic> event) async
{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('lat', double.tryParse(event['lat'].toString()) ?? 0.0);
  await prefs.setDouble('long', double.tryParse(event['long'].toString()) ?? 0.0);
  await prefs.setDouble('radius', double.tryParse(event['radius'].toString()) ?? 0.0);
  await prefs.setString('userid', event['userid']);

}

Future<void> _requestPermissions() async
{

  var status = await Permission.location.request();
  if (status.isGranted)
  {
    print("Location permission grantehttps://www.upwork.com/freelancers/~01490e5b60e828b46ed");
  }
  else if (status.isDenied)
  {
        print("Location permission denied");
        } else if (status.isPermanentlyDenied)
        {
          print("Location permission permanently denied");
          openAppSettings();
        }
}
