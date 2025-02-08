import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import '../../../360_survey_App/Components/Circular_progress.dart';
import '../../Components/Drawer.dart';
import '../../Components/Lms_home_page_appbar.dart';
import '../../Components/Slider.dart';
import '../Course_details.dart';
import 'Lms_dashboard_view_model.dart';

class lms_Dashboard extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<lms_Dashboard> {
  final _advancedDrawerController = AdvancedDrawerController();
  late LmsDashboardViewModel model;
 bool? isDrawerOpen;
  @override
  void initState() {
    model = LmsDashboardViewModel();
    model.courses();
    _advancedDrawerController.addListener(() {
      setState(() {
        isDrawerOpen = _advancedDrawerController.value == AdvancedDrawerValue.visible();

      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider<LmsDashboardViewModel>(
        create: (context) => model,
    child: Consumer<LmsDashboardViewModel>(
    builder: (context, viewModel, child) {
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
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child:
      model.isLoading ?
      circular_bar():
       Container(
         color: Colors.white,
          child: Column(
                  children: [
                    //VerticalSpacing(20),
                    Lms_homapge_bar(
                      title: "Premier Smart Learning Academy",
                      context: context,
                      adcontroller: _advancedDrawerController,
                      islogout: false,
                    ),


                    Expanded( // Use Expanded to take the remaining space
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),// Enable scrolling for the rest of the content
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 250,
                                child: SliderWithDots(),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Explore Courses",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              SizedBox(height: 10),
                              GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two cards per row
                                  childAspectRatio: 0.9, // Aspect ratio of each card
                                  crossAxisSpacing: 10.0, // Spacing between columns
                                  mainAxisSpacing: 10.0, // Spacing between rows
                                ),
                                itemCount: model.datalist.length,

                                // Total number of cards
                                shrinkWrap: true, // Ensure GridView doesn't take infinite height
                                physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
                                itemBuilder: (context, index) {
                                  var data=model.datalist[index];
                                  return InkWell(

                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseDetailsScreen(

                                        data: model.datalist[index],

                                      )));

                                    },


                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          color: Colors.white, // Different shades of blue
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              // Display the image from the network
                                              Stack(
                                                alignment: Alignment.bottomCenter, // Aligns the white container to the bottom
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(15.0), // Set your desired border radius
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.2), // Shadow color
                                                            spreadRadius: 2, // Spread radius
                                                            blurRadius: 5, // Blur radius
                                                            offset: Offset(0, 2), // Offset for the shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Image.network(
                                                        data.featureImage, // Assuming 'data' is an instance of your Course model
                                                        width: 150, // Set a width for the image
                                                        height: 100, // Set a height for the image
                                                        fit: BoxFit.cover, // Adjust the image fit
                                                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                          return Container(
                                                            width: 150, // Match the width of the image
                                                            height: 100, // Match the height of the image
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey, // Fallback color
                                                              borderRadius: BorderRadius.circular(15.0),
                                                              // Match border radius
                                                            ),
                                                            child: Center(child: Text('Failed to load image')), // Error handling
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  // White container for duration
                                                  Positioned(
                                                    top: 10,
                                                    right: 5,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.2), // Shadow color
                                                            spreadRadius: 2, // Spread radius
                                                            blurRadius: 5, // Blur radius
                                                            offset: Offset(0, 2), // Offset for the shadow
                                                          ),
                                                        ],
                                                      ),
                                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0), // Add some padding
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Duration: ', // Label text
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10,
                                                                color: AppColors.primary, // Your primary color for the label
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '${data.duration}', // Duration value
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10,
                                                                color: Colors.black, // Black color for the value
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),


                                              // You can add more widgets below, such as text for the course title
                                              //SizedBox(height: 10),
                                              Center(
                                                child: Text(
                                                  data.title, // Displaying the course title
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  textAlign: TextAlign.center, // Optional: Align the text to the center
                                                ),
                                              ),
//SizedBox(height: 10,),
Row(
mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    RichText(
          text: TextSpan(
            children: [
                TextSpan(
                  text: 'Author: ', // Label text
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: AppColors.primary, // Your primary color for the label
                  ),
                ),
                TextSpan(
                  text: '${data.author}', // Duration value
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.red, // Black color for the value
                  ),
                ),
            ],
          ),
    ),
  //Text("Author: ${data.author}", style: TextStyle(fontSize: 10),),


],)
                                              // Add more information if needed
                                            ],
                                          ),
                                        ),

                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),




      drawer: CustomSidebar(drawer: _advancedDrawerController,)
      );}) );
  }


}
