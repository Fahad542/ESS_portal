import 'package:ess/360_survey_App/Api_services/data/Local_services/Session.dart';
import 'package:flutter/material.dart';
import '../../../Ess_App/src/base/utils/constants.dart';
import '../../../Ess_App/src/styles/app_colors.dart';
import '../../Api_services/data/network/Api_services.dart';
import '../../Components/Custom_App_bar.dart';
import '../../Components/container.dart';
import '../../Models/Questions_model.dart';
import 'Feedback_view.dart';

class Given_Feedback extends StatefulWidget {
  final String giverid;
  final List<Question> question;
  const Given_Feedback({required this.question, required this.giverid});

  @override
  State<Given_Feedback> createState() => _Given_FeedbackState();
}

class _Given_FeedbackState extends State<Given_Feedback> {


  late final List<int?> selectedOptions = List.filled(widget.question.length, null);
  List<String> options=['Strongly Agree', 'Agree', 'Disagree', 'Strongly Disagree'];
  late final List<String?> comments = List.filled(widget.question.length, null);
  final TextEditingController commentController = TextEditingController();
  final PageController _pageController = PageController();
  Api api=Api();
  bool isLoading=false;
  int _currentPage = 0; // To track the current page
  Future<void> submit() async {
setState(() {
  isLoading = true;
});
    try {

      List<Map<String,String>> data= [];
      for (int i = 0; i < widget.question.length; i++) {
        // Ensure we don't try to access beyond the valid range
        if (i < selectedOptions.length && i < comments.length) {
          data.add({
            'feedback_taker': widget.giverid,
            'feedback_giver': UserData.empCode.toString(),
            'qid': widget.question[i].id ?? "",
            // Ensure id is valid
            'ans': options[selectedOptions[i] ?? 0] == "Agree" ? "agree" : options[selectedOptions[i] ?? 0] == "Strongly Agree" ? "strongly_agree" : options[selectedOptions[i] ?? 0] == "Strongly Disagree" ? "strongly_disagree" : options[selectedOptions[i] ?? 0] == "Disagree" ? "disagree" : '',
            // Make sure selectedOptions[i] is within bounds
            'comments': comments[i] ?? "",
          });
        }
      }
      print("data: ${data}");
      await api.submit(data).then((value) {

        if (value['status'] == 'success') {
          setState(() {
            _submitFeedback();
            isLoading = false;
          });

        }
      });

      // isLoading = false;
      // notifyListeners();

    } catch (e,stackTrace ) {
      setState(() {
        isLoading = false;
      });
      print("error: ${e}");
      print("Stack trace: $stackTrace");
      // Handle errors
    } finally {
      setState(() {
        isLoading = false;
      });
  // Reset loading state

    }
  }
  @override
  Widget build(BuildContext context) {
    return
      isLoading ?
          Center(child: CircularProgressIndicator(color: AppColors.primary,),)
      :
      SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Allow resizing to avoid overflow
        //appBar: GeneAppBar(title: 'Given Feedback',),
        body:


        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GenenralBar(title: 'Give your Feedback', context: context,),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.question.length,
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
                          Center(child: Text(widget.question[index].category.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                          SizedBox(height: 20,),
                          Container(
                            padding:EdgeInsets.all(8.0),
                            decoration:BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text(
                              "Q${index+1}: ${widget.question[index].question.toString()}",
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            widget.question[index].urdu.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(height: 15),
                          ...List.generate(4, (i) {
                            return RadioListTile<int>(
                              contentPadding: EdgeInsets.all(2),
                              title: Text(options[i].toString(),  style: TextStyle(fontSize: 13),),
                              value: i,
                              groupValue: selectedOptions[index],
                              onChanged: (value) {
                                setState(() {
                                  selectedOptions[index] = value; // Store selected option
                                });
                              },
                            );
                          }),
                          SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Additional Comments",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0), // Match the radius
                                borderSide: BorderSide(color: Colors.grey, width: 1.0), // Border when the field is enabled
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0), // Match the radius
                                borderSide: BorderSide(color: AppColors.primary, width: 2.0), // Border when the field is focused
                              ),
                            ),
                            onChanged: (value) {
                              comments[index] = value; // Store the comment for the current index
                            },
                            maxLines: 2,
                          ),


                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (index == 0)
                                Text(''),
                              if (index > 0)

                                containerwidget(
                                  title: "Previous",
                                  color: Colors.red,
                                  Textcolor: Colors.white,
                                  ontap: () {
                                    _pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                ),


                              if ( index < widget.question.length - 1 )

                                containerwidget(
                                  title: "Next",
                                  color: AppColors.primary,
                                  Textcolor: Colors.white,
                                  ontap: () {
                                    if (selectedOptions[index] == null) {
                                      // Show a warning message
                                      Constants.customWarningSnack(context, 'Please select an option before proceeding.');
                                    } else {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                ),

                              // Submit Button
                              if (index == widget.question.length - 1)// Show Submit button only on the last question
                                ElevatedButton(
                                  onPressed: (){
                                    if (selectedOptions[index] == null) {
                                      // Show a warning message
                                      Constants.customWarningSnack(context, 'Please select an option before submitting.');
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Conformation', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                                          content: Text('Are you sure you want to submit the feedback?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close dialog
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                submit();
                                              },
                                              child: Text('Yes'),
                                            ),

                                          ],
                                        ),
                                      );

                                    }
                                  }, child: Text("Submitted"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green, // Change button color to green
                                    onPrimary: Colors.white, // Change text color to white
                                  ),

                                ),
                            ],
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
              children: List.generate(widget.question.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? AppColors.primary : Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() {


    // Handle feedback submission logic here
    print("Feedback submitted!");
    print("Selected Options: $selectedOptions");

    print("Comments: ${comments}");
    // Clear the form or navigate to a different screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Feedbacks()),
          (Route<dynamic> route) => false, // This removes all previous routes
    );


    Constants.customSuccessSnack(context, 'Feedback Submitted Successfully.');
  }
}
