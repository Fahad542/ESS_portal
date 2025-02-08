import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import '../../../360_survey_App/Components/Circular_progress.dart';
import '../../../360_survey_App/Components/Textfeild.dart';
import '../../../360_survey_App/Components/button.dart';
import '../../Components/Custom_app_bar.dart';
import '../../Components/Drawer.dart';
import '../Signup.dart';
import 'Login_view_model.dart';


class Login_learning_management extends StatelessWidget {
  Login_learning_management();
  final DrawerController = AdvancedDrawerController();
  // SurveyLoginViewModel viewmodel=SurveyLoginViewModel();
  @override
  Widget build(BuildContext context) {
    return
      AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, Colors.black],
              ),
            ),
          ),
          controller: DrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: CustomSidebar(drawer: DrawerController,),
          child:


      ChangeNotifierProvider(
          create: (context) => lmsLoginViewModel(),
          child: Consumer<lmsLoginViewModel>(
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
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Custom_App_Bar
                              (
                              title: 'LOGIN',
                              onBackPressed: () {
                                DrawerController.showDrawer();
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
                            ),
                          SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Text("You don't have an account?"),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_up()));
                                  },
                                  child: Text("Sign Up" ,style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),))
                            ],)


                          ],
                        ),
                      ),
                    ),);
              }))); }
}
