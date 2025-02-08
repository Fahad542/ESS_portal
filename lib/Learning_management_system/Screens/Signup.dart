import 'package:ess/360_survey_App/Api_services/data/network/Api_services.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../../../360_survey_App/Components/Circular_progress.dart';
import '../../../360_survey_App/Components/Textfeild.dart';
import '../../../360_survey_App/Components/button.dart';
import '../../../360_survey_App/Screens/Login/Login_screen_view_model.dart';
import '../../../Ess_App/src/services/local/navigation_service.dart';
import '../../Ess_App/src/base/utils/constants.dart';
import '../Components/Custom_app_bar.dart';
import '../Components/Drawer.dart';
import 'Login/Login_view.dart';



class Sign_up extends StatefulWidget {
  Sign_up();

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final DrawerController = AdvancedDrawerController();

  bool  isloading=false;

  Api api=Api();

  TextEditingController username=TextEditingController();

  TextEditingController pass=TextEditingController();

  TextEditingController phone=TextEditingController();

  TextEditingController fullname=TextEditingController();

    void auth(BuildContext context){
      if(fullname.text.isEmpty)
        {
          Constants.customWarningSnack(context, "Please enter your Fullname");
        }
      else if (username.text.isEmpty)
        {
          Constants.customWarningSnack(context, "Please enter your Username");
        }
      else if (phone.text.isEmpty)
      {          Constants.customWarningSnack(context, "Please enter your Number");

      }
      else if (pass.text.isEmpty)
      {
        Constants.customWarningSnack(context, "Please enter your Password");
      }
      else {
        sign_up(username.text,pass.text,fullname.text,phone.text,context);
      }
    }

  void sign_up(String username, String password, String fullname, String mobile, BuildContext context) async
  {
    setState(() {
      isloading =true;
    });
       await api.signup(username, password, mobile, fullname).then(
               (value) {
                 if(value['code'] =="200")
                   {
                     setState(() {
                       isloading =false;
                     });
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_learning_management()));
                     Constants.customSuccessSnack(context, value['msg']);
                   }
                 else
                 {
                   setState(() {
                     isloading =false;
                   });
                   Constants.customErrorSnack(context, value['msg']);
                 }
               }
       );
  }

  @override
  Widget build(BuildContext context) {
    return

    isloading ? Center(child: CircularProgressIndicator(color: AppColors.primary,),)
    :
                      Scaffold(
                        resizeToAvoidBottomInset: true, // Allow resizing to avoid overflow
                        body: SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Custom_App_Bar
                                  (
                                  title: 'Sign Up',
                                  onBackPressed: () {
                                Navigator.pop(context);
                                  },
                                  onNotificationPressed: () {

                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [

                                        SizedBox(height: 25,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // InkWell(
                                            //     onTap: (){
                                            //       NavService.appmenu();
                                            //     },
                                            //     child: Icon(Icons.arrow_back)),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 30,),
                                                Image.asset("assets/images/prm.jpeg", height: 200,width: 200,),
                                                SizedBox(height: 30,),
                                                CusTextField(

                                                  controller: fullname,
                                                  labelText: 'Full Name',
                                                  prefixIcon: Icon(Icons.person),),
                                                SizedBox(height: 15,),
                                                CusTextField(

                                                  controller: username,
                                                  labelText: 'Username',
                                                  prefixIcon: Icon(Icons.person),),

                                                SizedBox(height: 15,),
                                                CusTextField(

                                                  controller: phone,
                                                  labelText: 'Phone number',
                                                  prefixIcon: Icon(Icons.phone),),
                                                SizedBox(height: 15,),
                                                CusTextField(controller: pass,
                                                  labelText: 'Password',
                                                  prefixIcon: Icon(Icons.lock),
                                                  obscureText: true,),

                                                SizedBox(height: 20,),
                                                roundbutton(title: 'Sign Up', onpress: () {
                                                  auth(context);

                                                  // Navigator.push(context, MaterialPageRoute(builder: (
                                                  //     context) => Dashboard_screen()));
                                                },)
                                              ],),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),);
                  } }

