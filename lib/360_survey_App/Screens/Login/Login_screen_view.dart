import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Ess_App/src/services/local/navigation_service.dart';
import '../../Components/Circular_progress.dart';
import '../../Components/Textfeild.dart';
import '../../Components/button.dart';

import '../Dashboard/Dashboard_view.dart';
import 'Login_screen_view_model.dart';

class Login_servey_app extends StatelessWidget {
   Login_servey_app();
  // SurveyLoginViewModel viewmodel=SurveyLoginViewModel();
  @override
  Widget build(BuildContext context) {
    return

      ChangeNotifierProvider(
          create: (context) => SurveyLoginViewModel(),
          child: Consumer<SurveyLoginViewModel>(
          builder: (context, viewModel, child) {
            return
              viewModel.isLoading ?
                  circular_bar():
              Scaffold(
                resizeToAvoidBottomInset: true, // Allow resizing to avoid overflow
                // appBar: AppBar(
                //
                //   elevation: 0.0,
                // ),
                // backgroundColor: AppColors.primary.withOpacity(0.1),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: (){
                                  NavService.appmenu();
                                },
                                child: Icon(Icons.arrow_back)),
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
                                Image.asset("assets/images/360fb.png", height: 250,width: 250,),
                                SizedBox(height: 30,),
                                CusTextField(

                                  controller: viewModel.emailcontroller,
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),),
                                SizedBox(height: 15,),
                                CusTextField(controller: viewModel.passwordcontroller,
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  obscureText: true,),
                                SizedBox(height: 20,),
                                roundbutton(title: 'LOGIN', onpress: () {
                                  viewModel.login(context);

                                  // Navigator.push(context, MaterialPageRoute(builder: (
                                  //     context) => Dashboard_screen()));
                                },)
                              ],),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),);
          })); }
}
