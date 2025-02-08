import 'package:ess/Ess_App/src/services/remote/api_service.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/Loan/customtextfeild.dart';
import 'package:ess/Ess_App/src/views/local_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../base/utils/constants.dart';
import '../../configs/app_setup.locator.dart';
import '../../models/api_response_models/changepassword_model.dart';
import '../../models/api_response_models/user.dart';
import '../../services/local/auth_service.dart';
import '../../services/local/navigation_service.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/top_app_bar.dart';
import '../dashboard/dashboard_view_model.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {

  @override
  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> list = [];
  bool isloading = false;

  @override
  void initState() {
    fetcghdata();
    super.initState();
  }

  Future<void> fetcghdata() async {
    list = await db.getlocation();
    setState(() {

    });
  }

  AuthService? authService;

  TextEditingController _controller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  AuthService _authService = locator<AuthService>();

  User? get
  currentUser => _authService.user;


  Widget build(BuildContext context) {
    return


              SafeArea(
                child: Column(
                  children: [
                    GeneralAppBar(
                        title: "Profile Screen",

                        onMenuTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        onNotificationTap: () {}),

                    SizedBox(height: 30,),

                    Expanded(
                      flex: 3,
                      child: Container(

                        child: (
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/profile.png'),
                                  radius: 80, // specify the radius as needed
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${currentUser?.userName.toString()}",
                                      style: TextStyle(
                                          fontSize: 22, fontWeight: FontWeight
                                          .bold),),
                                    Text("(${currentUser?.userId.toString()})")
                                  ],
                                ),

                                Text("${currentUser?.member_designation
                                    .toString()}",
                                  style: TextStyle(fontSize: 14),),

                                SizedBox(height: 25,),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Change Password'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[

                                              CustomTextField(controller: _controller, labelText: "Password",

                                              )
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Save Password'),
                                              onPressed: () async {
                                                ApiService api = ApiService();
                                                var data = await api.changepassword(context, _controller.text.toString());

                                                // Delay the pop to make sure the widget is still active
                                                if (mounted) {
                                                  Navigator.of(context).pop();
                                                }

                                                data.when(
                                                  success: (data) {
                                                    if (mounted) {
                                                      Constants.customSuccessSnack(context, data.statusMessage);
                                                    }
                                                  },
                                                  failure: (e, ) {
                                                    if (mounted) {
                                                      print(e.toString());
                                                      Constants.customErrorSnack(context, e.toString());
                                                    }
                                                  },
                                                );
                                              },

                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
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
                                                0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(Icons.edit, color: Colors.white),
                                          SizedBox(width: 8),
                                          Text("Change Password",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Change Phone Number'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              CustomTextField(
                                                controller: numbercontroller,
                                                labelText: "Phone number",
                                                inputType:TextInputType.number ,
                                                             )
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Save Phone number'),
                                              onPressed: () async {
                                                ApiService api = ApiService();

                                                // Get the phone number from the controller
                                                String phoneNumber = numbercontroller.text.trim();

                                                // Check if the phone number is not empty and follows the validation rules
                                                if (phoneNumber.isNotEmpty) {
                                                  // Validate the phone number
                                                  String pattern = r"^92\d{10}$";  // Starts with "92" followed by 10 digits
                                                  RegExp regExp = RegExp(pattern);

                                                  if (regExp.hasMatch(phoneNumber)) {
                                                    // If the phone number is valid, proceed with the API call
                                                    var data = await api.changephonenumber(context, phoneNumber);

                                                    // Delay the pop to ensure the widget is still active
                                                    if (mounted) {
                                                      Navigator.of(context).pop();
                                                    }

                                                    // Handle the response
                                                    data.when(
                                                      success: (data) {
                                                        if (mounted) {
                                                          Constants.customSuccessSnack(context, data);
                                                          numbercontroller.clear();
                                                        }
                                                      },
                                                      failure: (e) {
                                                        if (mounted) {
                                                          print(e.toString());
                                                          Constants.customErrorSnack(context, e.toString());
                                                        }
                                                      },
                                                    );
                                                  } else {
                                                    // Show error if the phone number does not match the pattern
                                                    Constants.customErrorSnack(context, "Please enter a valid phone number starting with 92 and 12 digits.");
                                                  }
                                                } else {
                                                  // Show error if the number is empty
                                                  Constants.customErrorSnack(context, "Please enter the number first.");
                                                }
                                              },

                                            ),
                                          ],
                                        );
                                      },
                                    );
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
                                                0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                              Icons.edit, color: Colors.white
                                          ),
                                          // Icon widget added here
                                          SizedBox(width: 8),
                                          // Adding some space between icon and text
                                          Text("Change Phone Number",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ),
                    )
                  ],
                ));

  }
}