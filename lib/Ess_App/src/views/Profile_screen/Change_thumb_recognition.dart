import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/app_setup.locator.dart';
import '../../models/api_response_models/user.dart';
import '../../services/local/auth_service.dart';
import '../../services/local/navigation_service.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../login/local/local_db.dart';

class thumb_recogition extends StatefulWidget {
  const thumb_recogition();

  @override
  State<thumb_recogition> createState() => _thumb_recogitionState();
}
final dbHelper = DatabaseHelper();
AuthService? authService ;
TextEditingController _controller = TextEditingController();
AuthService _authService = locator<AuthService>();

User? get
currentUser => _authService.user;
Map<String,  dynamic> data={};
class _thumb_recogitionState extends State<thumb_recogition> {
  @override

  @override
  void initState() {

    super.initState();
    getdata();
  }
  Future<void> getdata() async {
    data = (await dbHelper.getUser())!;
    print("data: ${data['email']}");
    setState(() {
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          SizedBox(height: 20,),
          GeneralAppBar(
              title: "Reset Thumb Recognition",
              onMenuTap: () {
                Scaffold.of(context).openDrawer();
              },
              onNotificationTap: () {}),
          Image.asset('assets/images/file.png', height: 40,width: 40,),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Email: ", style: TextStyle(fontWeight: FontWeight.bold),),
                if(data.isNotEmpty)
                Text(data['email']),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Password: ", style: TextStyle(fontWeight: FontWeight.bold),),
                if(data.isNotEmpty)
               Text(data['password']),

              ],
            ),
          ),


          InkWell(
            onTap: ()async  {
              await dbHelper.deleteUser();
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.clear();
              NavService.login();

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(
                          0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Icon widget added here
                    SizedBox(width: 8),
                    // Adding some space between icon and text
                    Text("Reset Authentication", style: TextStyle(
                        color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
      ],),
    );
  }
}
