import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Ess_App/src/styles/app_colors.dart';
import '../../Components/Circular_progress.dart';
import '../../Components/Custom_App_bar.dart';
import '../../Components/Custom_drawer.dart';
import '../../Components/Feedback_table.dart';
import '../Feedback/Feedback_view_model.dart';
import 'check_poll_view_model.dart';

class check_poll extends StatefulWidget {
  const check_poll();

  @override
  State<check_poll> createState() => _checkState();
}

class _checkState extends State<check_poll> {
  late PollViewModel model;

  @override
  void initState() {
    model = PollViewModel();
    model.fecthdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider<PollViewModel>(
          create: (context) => model,
          child: Consumer<PollViewModel>(
          builder: (context, viewModel, child) {
            return
              Scaffold(

                  drawer: CustomDrawer(),
                  body:

              SafeArea(

                  child: Column(
                children: [
                CustomBar(title: 'Check Your Poll',context: context),

                  Expanded(
                  child:
              viewModel.isLoading
                ? circular_bar() // Replace with your loading widget
                :


                    //Lottie.asset(
                    //   'assets/lottie/Animation - 1730288682231.json', // Path to your Lottie file
                    //   width: 100, // Width of the animation
                    //   height: 100, // Height of the animation
                    //   fit: BoxFit.fill, // How to fit the animation
                    // ),
                    Column(
                      children: [

                        Image.asset("assets/images/poll.png", height: 130,width: 130,),
                        Expanded(
                          child: ListView.builder(

                            physics: BouncingScrollPhysics(),
                            itemCount: viewModel.datalist.length,
                            itemBuilder: (context, index) {
                              var data=viewModel.datalist[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                                child: poll(

                                  name: data.username,
                                  empcode: data.empCode, ontap: () {  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

            )])));
          }));}
}
