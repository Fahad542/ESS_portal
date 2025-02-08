import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';

class BackgroundServiceManager {

  @pragma('vm:entry-point')
  static Future<void> start() async {
    print("Background service started");

    WidgetsFlutterBinding.ensureInitialized();

    // Fetch preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double lat = prefs.getDouble('lat') ?? 0.0;
    double long = prefs.getDouble('long') ?? 0.0;
    double radius = prefs.getDouble('radius') ?? 0.0;
    String userId = prefs.getString('userid') ?? '';

    // Define location settings
    final settings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      intervalDuration: Duration(seconds: 20),
      distanceFilter: 0,
    );

    // Listen for position updates
    Geolocator.getPositionStream(locationSettings: settings).listen((pos) async {
      print("Location updated: lat:${pos.latitude} long:${pos.longitude}");

      // Check attendance based on current location and preferences
      await _checkAttendance(pos.latitude, pos.longitude, lat, long, radius, userId);
    });

    // Listen for incoming events from the service
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

  // Method to check attendance based on the user's location
  static Future<void> _checkAttendance(
      double latitude, double longitude, double targetLat, double targetLong, double distance, String userId) async {
    double distanceInMeters = Geolocator.distanceBetween(targetLat, targetLong, latitude, longitude);

    bool hasCheckedIn = await _hasCheckedInToday();

    if (!hasCheckedIn) {
      if (distanceInMeters <= distance) {
        await _markAttendance(latitude, longitude, userId, targetLat, targetLong);
      } else {
        print("Too far to mark attendance. Distance: $distanceInMeters meters, Allowed: $distance meters");
      }
    } else {
      print("Attendance already marked for today.");
    }
  }

  // Check if the user has checked in today
  static Future<bool> _hasCheckedInToday() async {

    return false;

  }


  static Future<void> _markAttendance(double latitude, double longitude, String userId, double targetLat, double targetLong) async {
    try {
      final response = await http.get(
        Uri.parse('https://your-api.com/mark_attendance?userId=$userId&lat=$latitude&lon=$longitude&targetLat=$targetLat&targetLon=$targetLong'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Attendance marked: ${data['message']}");
      } else {
        print("Failed to mark attendance: ${response.statusCode}");
      }
    } catch (e) {
      print("Error marking attendance: $e");
    }
  }


  static Future<void> _updatePreferences(Map<String, dynamic> event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lat', double.tryParse(event['lat'].toString()) ?? 0.0);
    await prefs.setDouble('long', double.tryParse(event['long'].toString()) ?? 0.0);
    await prefs.setDouble('radius', double.tryParse(event['radius'].toString()) ?? 0.0);
    await prefs.setString('userid', event['userid']);
  }
 static Future<void> printcordinantes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double lat = prefs.getDouble('lat') ?? 0.0;
    double long = prefs.getDouble('long') ?? 0.0;
    double radius = prefs.getDouble('radius') ?? 0.0;
    String userId = prefs.getString('userid') ?? '';

    print(" Api latitude: ${lat}, longitude : ${long} , radius: ${radius}");
  }
  // Start the background service
  static void startService() {
    FlutterBackgroundService.initialize(start);
  }


  static void stopService() {
    FlutterBackgroundService().stopBackgroundService();
  }
}









