
import 'dart:convert';
import 'package:ess/Ess_App/src/views/local_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



DateTime? lastApiCallTime;
DatabaseHelper database=DatabaseHelper();
class LocationService {
  @pragma('vm:entry-point')
 static Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Future<void> printcordinantes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double lat = prefs.getDouble('lat') ?? 0.0;
      double long = prefs.getDouble('long') ?? 0.0;
      double radius = prefs.getDouble('radius') ?? 0.0;
      String userId = prefs.getString('userid') ?? '';

      print(" Api latitude: ${lat}, longitude : ${long} , radius: ${radius}");
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>? activeEvents ;
    FlutterBackgroundService().onDataReceived.listen((event) async {
      activeEvents = event;
      print("Received event: $activeEvents");

      if (event is Map) {
        if (event!.containsKey('lat')) {
          await _updatePreferences(activeEvents!);
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
        else if (event!.containsKey('clear') && event['clear'] == '"clearcordinantes"' ) {
          activeEvents?.clear();
          print("Data is clear");
        }
      } else {
        print("Received event is null or not a Map: $event"); // Log the received event
      }
    }
    );
  }
  static Future<void> _checkAttendance(double latitude, double longitude, double targetLat, double targetLong, double distance, String userId) async
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
          await
          getAttendance
            (
              latitude.toString(),
              longitude.toString(),
              userId,
              targetLat.toString(),
              targetLong.toString(),
            );
          print("Attendance marked at distance: $distanceInMeters meters");
          lastApiCallTime = DateTime.now();

        }
      }
      else
      {
        print("Attendance not marked, too far. Distance: $distanceInMeters meters, Allowed Distance: $distance meters");
      }
    }

    else {

      print("Attendance already marked for today.");

         }
  }
  static Future<void> getAttendance(String latitude, String longitude, String userid, String targetlat, String targetlong) async {
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
            await database.insercheckin(DateTime.now().toIso8601String().split('T')[0], targetlat, targetlong,
                DateTime.now().toIso8601String().split('T')[0],
                DateTime.now().toIso8601String().substring(11, 16), latitude,longitude);
            print("Save data in local sucessfully");
          }
          else
          {
            print("Attendannce has been marked");
          }
          print("Save data in firebabse sucessfully");

          print("Attendance data: ${data['data']}");
        }
        else {
          print("Attendance is already marked");
        }
      } else {
        // Handle error
        print("Failed to fetch attendance: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching attendance: $e");
    }

  }
 static Future<void> _updatePreferences(Map<String, dynamic> event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lat', double.tryParse(event['lat'].toString()) ?? 0.0);
    await prefs.setDouble('long', double.tryParse(event['long'].toString()) ?? 0.0);
    await prefs.setDouble('radius', double.tryParse(event['radius'].toString()) ?? 0.0);
    await prefs.setString('userid', event['userid']);
  }

}
