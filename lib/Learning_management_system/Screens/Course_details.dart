import 'package:ess/360_survey_App/Api_services/data/Local_services/Session.dart';
import 'package:ess/360_survey_App/Api_services/data/network/Api_services.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Learning_management_system/Screens/Course_details_view.dart';
import 'package:flutter/material.dart';
import '../../Ess_App/src/base/utils/constants.dart';
import '../Components/Custom_app_bar.dart';
import '../Models/Courses.dart';
import 'Lms_Dashboard/Lms_dashboard_view.dart';
import 'Login/Login_view.dart';

class CourseDetailsScreen extends StatefulWidget {
  Course data;
  
   CourseDetailsScreen({required this.data});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  Api api=Api();

 bool enrollcourse=false;
 bool isloading=false;
  @override
  Future<void> checkenroll() async
  {
    setState(() {
      isloading =true;
    });
    Map<String, dynamic> datas= await api.check_course_enroll(widget.data.id);
    if(datas['code'] =="200")
      {
       // Constants.customSuccessSnack(context, datas['msg']);
        setState(() {
          isloading =false;
        });
        if(datas['msg'] == "User Enrolled")
          {
     print(datas['msg']);
          }
      }
    else {
      setState(() {
        isloading =false;
        enrollcourse=true;
        print(datas['msg']);
      });

    }
  }


  Future<void> enroll() async
  {
    setState(() {
      isloading =true;
    });
    Map<String, dynamic> datas= await api.enroll_course(widget.data.id);
    if(datas['code'] =="200")
    {

      setState(() {
        isloading =false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => lms_Dashboard()),
            (Route<dynamic> route) => false, // This will remove all previous routes
      );
      Constants.customSuccessSnack(context, datas['msg']);
    }
  }

  Future<void> course_detail() async {
    setState(() {
      isloading =true;
    });
    List<dynamic> datas= await api.course_detail(widget.data.id);
    for (var course in datas) {
      setState(() {
        isloading =false;
      });
      print('Course ID: ${course['content']}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Course_detail_view(data: course['content'], attachments: course['attachments'] ?? [],)),
          
      );

    }
  }

@override
  void initState() {
  checkenroll();
    super.initState();
  }
  Widget build(BuildContext context)

  {

    return
      isloading ?
      Center
        (
        child:
      CircularProgressIndicator(
        color: AppColors.primary,
                                ),
        )
          :

      Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),

      body:



      Column(
        children: [
          SizedBox(height: 30,),
          Custom_App_Bar(title: 'Course Details',
            onBackPressed: () {
            Navigator.pop(context);
              //DrawerController.showDrawer();

            }, onNotificationPressed: () {  },),
          SizedBox(height: 20,),
          Column(
            children: [
//     Row(
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                            spreadRadius: 2, // Spread of the shadow
                            blurRadius: 5,  // Softness of the shadow
                            offset: Offset(0, 3), // Horizontal and vertical offset
                          ),
                        ],
                      ),
                      child:
                      Row(
                        children: [
                          Text(
                            "Duration: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                           SizedBox(width: 4),
                          Text
                            (
                            widget.data.duration,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(  boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Shadow color with opacity
                    spreadRadius: 3, // Spread of the shadow
                    blurRadius: 5,  // Softness of the shadow
                    offset: Offset(0, 4), // Horizontal and vertical offset
                  ),
                ],),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18), // Set your desired radius
                    child: Image.network(
                      widget.data.featureImage,
                      fit: BoxFit.cover, // Ensures the image scales properly
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10),
                child: Text(widget.data.title, style: TextStyle(color: AppColors.primary, fontSize: 25,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 5,),
              if(widget.data.summary.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color with opacity
                      spreadRadius: 3, // Spread of the shadow
                      blurRadius: 5,  // Softness of the shadow
                      offset: Offset(0, 4), // Horizontal and vertical offset
                    ),
                  ],),
                  child:

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Center(child: Text(widget.data.summary, textAlign: TextAlign.center,)),
                      ],
                    ),
                  )
                ),
              ),

            ],
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onPressed: ()
              {
                if(lmsUserData.member_id != null)
                {
                 if (enrollcourse == true)
                 {
                   enroll();
                 }
                 if (enrollcourse == false)
                   course_detail();
                 }
               else
                 {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_learning_management()));
                 Constants.customWarningSnack(context, "Please login first");
                 }
               },
              child:  Text(enrollcourse ==false ? "View Course" : "Enroll Course"),
            ),
          ),
        ),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}








