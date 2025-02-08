import 'dart:convert';
import 'package:ess/360_survey_App/Screens/Login/Login_screen_view.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Learning_management_system/Screens/Lms_Dashboard/Lms_dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import '360_survey_App/Api_services/data/Local_services/Session.dart';
import '360_survey_App/Screens/Dashboard/Dashboard_view.dart';
import 'Ess_App/src/configs/app_setup.locator.dart';
import 'Ess_App/src/services/local/auth_service.dart';
import 'Ess_App/src/services/remote/api_service.dart';
import 'Ess_App/src/styles/text_theme.dart';
import 'package:http/http.dart' as http;
import 'Ess_App/src/models/api_response_models/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Ess_App/src/views/dashboard/dashboard_view.dart';
import 'Ess_App/src/views/local_db.dart';
import 'Ess_App/src/views/login/login_view.dart';


class AppMenu extends StatefulWidget {
   AppMenu({Key? key}) : super(key: key);


  @override

  State<AppMenu> createState() => _AppMenuState();
}


class _AppMenuState extends State<AppMenu> {
  AuthService? authService ;
  AuthService _authService = locator<AuthService>();
  User? get currentUser => _authService.user;
  DateTime? lastApiCallTime;
  DatabaseHelper database = DatabaseHelper();
  ApiService api = ApiService();
  DateTime? lastLocationUpdateTime;
  String? userid;
  final currentTimes = DateTime.now();
  String currentTime = DateTime.now().toIso8601String().substring(11, 16);
  final List<Map<String, dynamic>>
  menuItems =
  [
    {'title': 'Premier Ess portal', 'icon': "assets/images/premierlogo.png"},
    {'title': 'Profile', 'icon': "assets/images/premier.png"},
    {'title': 'Settings', 'icon': "assets/images/premier.png"},
    {'title': 'Notifications', 'icon': "assets/images/premier.png"},
  ];
  List data = [];
  bool isloading = false;
  bool isDialogShown = false;
  bool? isDialogShownPref;
  Future<List> Api() async
  {
    var response = await http.get(Uri.parse("https://premierspulse.com/ess/scripts/dashboard_script.php"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['Forms'] as List<dynamic>;
    }
    return [];
  }

  Future<void> fetchdata() async
  {
    setState(() {
      isloading = true;
    });
    data = await Api();
    setState(() {
      isloading = false;
    });
    print(data);
  }

  Future<void> Dialogbox(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDialogShownPref = prefs.getBool('isDialogShown');

    if (isDialogShownPref == null) {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Background Location Permission',
                style: TextStyle(fontWeight: FontWeight.bold), // Optional: Bold text
              ),
            ),
            content: Text(
              'We use your background location to mark your check-in when you arrive at the premises. '
                  'Your data is secure and used solely for this purpose.',
            ),
            actions: <Widget>
            [

              TextButton(
                child: Text('OK'),
                onPressed: () async
                {
                  Navigator.of(context).pop();
                  await prefs.setBool('isDialogShown', true);
                },
              ),

            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    fetchdata();

    // if(isDialogShownPref == null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Dialogbox(context);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      body: isloading
          ? Center(child: CircularProgressIndicator(color: AppColors.primary))
          : Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/loho.png", height: 130, width: 130)),
                  DigitalClock(
                    digitAnimationStyle: Curves.easeOutCirc,
                    is24HourTimeFormat: false,
                    areaDecoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    secondDigitTextStyle: TextStyling.extraBold24.copyWith(
                      color: AppColors.white,
                    ),
                    hourMinuteDigitTextStyle: TextStyling.extraBold24.copyWith(
                      color: AppColors.white,
                      fontSize: 70,
                    ),
                    amPmDigitTextStyle: TextStyling.extraBold24.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Text("All Apps", style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var datalist = data[index];
                return GestureDetector(
                  onTap: () async {
                    // Handle menu item taps
                    if (datalist['menu_name'] == "ESS") {
                      if (currentUser?.userName == null) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardView()));
                      }
                    }
                    if (datalist['menu_name'] == "360 Feedback") {
                      if (UserData.username == null) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login_servey_app()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                      }
                    }
                    if (datalist['menu_name'] == "LMS") {
                      Sharedprefrence sp = Sharedprefrence();
                      await sp.getlmsdata();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => lms_Dashboard()));
                    }
                    if (datalist['menu_name'] == "CHATBOT") {
                      final url = 'https://wa.me/03348788282?text=Hi';
                      await launch(url);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(datalist['menu_logo'], height: 110, width: 110),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
