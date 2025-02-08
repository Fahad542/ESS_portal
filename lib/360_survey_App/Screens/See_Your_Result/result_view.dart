import 'package:ess/360_survey_App/Screens/See_Your_Result/result_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Ess_App/src/base/utils/constants.dart';
import '../../../Ess_App/src/styles/app_colors.dart';
import '../../../Ess_App/src/views/dashboard/widget/available_leaves_chart.dart';
import '../../Components/Chart.dart';
import '../../Components/Circular_progress.dart';
import '../../Components/Custom_App_bar.dart';
import '../../Components/Custom_drawer.dart';
import '../../Components/container.dart';

class Result extends StatefulWidget {
  //final List<Question> question;
  const Result();

  @override
  State<Result> createState() => _Given_FeedbackState();
}

class _Given_FeedbackState extends State<Result> {


  late final List<int?> selectedOptions = List.filled(model.questions.length, null);
  List<String> options=['Strongly Agree', 'Agree', 'Disagree', 'Strongly Disagree'];
  late final List<String?> comments = List.filled(model.questions.length, null);

  final TextEditingController commentController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPage = 0; // To track the current page
  late ResultViewModel model;
  @override
  void initState() {
    model = ResultViewModel();
    model.fetchquestions();
    model.resultdata("1");
    super.initState();
  }
  // @override
  // void dispose() {
  //   _pageController.dispose(); // Clean up controller
  //   super.dispose();
  // }
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider<ResultViewModel>(
          create: (context) => model,
          child: Consumer<ResultViewModel>(
              builder: (context, viewModel, child) {
                return
                  Scaffold(

                    drawer: CustomDrawer(),
                    body:

                    SafeArea(

                        child: Column(
                            children: [
                            CustomBar(title: 'Results',context: context),

                        Expanded(
                        child:
                  viewModel.isLoading
                    ? circular_bar() // Replace with your loading widget
                    :
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.questions.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index; // Update current page
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView( // Wrap in SingleChildScrollView
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: Text(
                                      model.questions[index].category
                                          .toString(), style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),)),
                                    SizedBox(height: 20,),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(
                                              0.1),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Text(
                                        "Q${index + 1}: ${model.questions[index]
                                            .question.toString()}",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    if(model.resultlist !=null)
                                    Container(
                                      height:200,
                                      child: Chart(data: model.resultlist!,),
                                    ),

                                    SizedBox(height: 20),

                                    if (viewModel.resultlist != null && viewModel.resultlist!.comments != null)
                                    ListView.builder(
                                      shrinkWrap: true,
                                        itemCount: viewModel.resultlist!.comments.length,
                                        itemBuilder: (BuildContext context, index)
                                    {
                                      var data=viewModel.resultlist!.comments[index];
                                      return
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Comments: ",
                                                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                                              ),
                                              TextSpan(
                                                text: data,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );

                                    }
                                    ),
                                    //Text(model.resultlist!.comments.comment.length.toString()),



                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [

                                        if (index == 0)
                                          Text(''),
                                        if (index >
                                            0) // Show Previous button only if it's not the first question
                                          containerwidget(
                                            title: "Previous",
                                            color: Colors.red,
                                            Textcolor: Colors.white,
                                            ontap: () async {
                                              print("number: ${model.questions[index-1].id}");
                                              await model.resultdata1(model.questions[index-1].id);
                                              _pageController.previousPage(
                                                duration: Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeIn,
                                              );
                                            },
                                          ),

                                        if (index < model.questions.length - 1)
                                        containerwidget(
                                          title:  "Next",
                                          color: AppColors.primary,
                                          Textcolor: Colors.white,
                                          ontap: () async {
                                            if (index < model.questions.length - 1) {
                                              print("number: ${model.questions[index+1].id}");
                                              await model.resultdata1(model.questions[index+1].id);

                                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                                                if (_pageController.hasClients) { // Check if the controller is attached
                                                  _pageController.nextPage(
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeIn,
                                                  );
                                                }
                                            // });
                                            } else {
                                              _submitFeedback();
                                            }
                                          },


                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    if(model.resultlist !=null)
                                    Container(
                                      height: 100,
                                      child: PieChartSample(

                                          dataMap : {
                                            "Strongly Agree": double.tryParse(model.resultlist!.stronglyAgree.toString()) ?? 0.0,
                                            "Agree": double.tryParse(model.resultlist!.agree.toString()) ?? 0.0,
                                            "Disagree": double.tryParse(model.resultlist!.disAgree.toString()) ?? 0.0,
                                            "Strongly Disagree": double.tryParse(model.resultlist!.stronglyDisagree.toString()) ?? 0.0
                                          }

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Dots Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            model.questions.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 16),

                    ],
                  ))])));

              })); }

  void _submitFeedback() {


    // Handle feedback submission logic here
    // print("Feedback submitted!");
    // print("Selected Options: $selectedOptions");
    //
    // print("Comments: ${comments}");
    // Clear the form or navigate to a different screen
    //Navigator.pop(context); // or clear the form
    Constants.customSuccessSnack(context, 'Feedback Submitted Successfully.');
  }
}
