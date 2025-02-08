import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../Components/Circular_progress.dart';
import '../../Components/Custom_App_bar.dart';
import '../../Components/Custom_drawer.dart';
import '../../Components/Feedback_table.dart';
import 'Feedback_view_model.dart';
import 'Given_feedback.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks();

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  late FeedbackViewModel model;

  @override
  void initState() {
    super.initState();
    model = FeedbackViewModel();
    model.fecthdata();
    model.fetchquestions();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedbackViewModel>(
      create: (context) => model,
      child: Consumer<FeedbackViewModel>(
        builder: (context, viewModel, child) {

          return
          Scaffold(

            drawer: CustomDrawer(),
            body:

            SafeArea(

                child: Column(
                    children: [
                    CustomBar(title: 'Feedbacks',context: context),

                Expanded(
          child:

           viewModel.isLoading
              ? circular_bar() // Replace with your loading widget
              :

             Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: viewModel.datalist.length,
                itemBuilder: (context, index) {
                  var data=viewModel.datalist[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: EmployeeTable(

                      name: data.username,
                      empcode: data.empCode,
                      feedback: data.feedbackGiven,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Given_Feedback(question: viewModel.questions, giverid: data.empCode,),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          )])));
        },
      ),
    );
  }
}