import 'package:background_location/background_location.dart';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/utils/settings_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Location.dart';
import '../shared/top_app_bar.dart';
import 'local_db.dart';

class checkin_screen extends StatefulWidget {
  const checkin_screen({Key? key}) : super(key: key);

  @override
  State<checkin_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<checkin_screen> {

  @override
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseHelper db=DatabaseHelper();
 // final LocationServiceController _controller = LocationServiceController();

  List<Map<String, dynamic>> list = [];
  @override
  void initState() {
    // TODO: implement initState
    fetcghdata();
    //startBackgroundLocation();
    super.initState();
  }
void fetcghdata() async {
  list = await db.getlocation();
  setState(() {

  });
}





  void callback(LocationDto locationDto) {

    print("Location: ${locationDto.latitude}, ${locationDto.longitude}");
  }

  Future<void> startback() async {
    try {
      print("Initializing BackgroundLocator...");
      await BackgroundLocator.initialize();
      print("BackgroundLocator initialized");

      if (callback == null) {
        print("Callback is null");
        return;
      }

      var argsMap = SettingsUtil.getArgumentsMap(
        callback: (LocationDto locationDto) {
          print("Location received: ${locationDto.latitude}, ${locationDto.longitude}");
        },
      );

      if (argsMap == null) {
        print("Arguments map is null");
        return; // Handle this appropriately
      }

      BackgroundLocator.registerLocationUpdate(callback);
      print("Location update registered");
    } catch (e) {
      print("Error starting background location: $e");
    }
  }







  Widget build(BuildContext context) {

    return


      SafeArea(
        child: Column(
        children: [
        GeneralAppBar(
        title: "Check Ins",

        onMenuTap: () {
      Scaffold.of(context).openDrawer();
    },
    onNotificationTap: () {}),

    SizedBox(height: 30,),
    list.isNotEmpty
          ?
    Expanded(
    child: ListView.builder(
    shrinkWrap: true,
    itemCount: list.length,

    itemBuilder: (BuildContext context, index){

    var data=list[index];

    return Row(children: [
    Text("${index}: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
    Text('${data['lat']}'),
    SizedBox(width: 7,),
    Text('${data['long']}'),
    SizedBox(width: 7,),
    Text(' ${data['date']}'),
    SizedBox(width: 7,),
      Text(' ${data['time']}'),
      SizedBox(width: 7,),




    ],);
    }),
    ): Text("No  data")



        ]));}}