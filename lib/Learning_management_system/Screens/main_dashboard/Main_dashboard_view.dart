import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import '../../../360_survey_App/Api_services/data/network/Api_services.dart';
import '../../../Ess_App/src/styles/app_colors.dart';
import '../../Components/Custom_app_bar.dart';
import '../../Components/Drawer.dart';
import '../Course_details_view.dart';
import 'Main_dashboard_view_model.dart';

class Main_dashboard extends StatefulWidget {
  const Main_dashboard();

  @override
  State<Main_dashboard> createState() => _Main_dashboardState();
}

class _Main_dashboardState extends State<Main_dashboard>
{
  final _advancedDrawerController = AdvancedDrawerController();
  late MainDashboardViewModel model;
  Api api=Api();
  Future<void> course_detail(String id) async {
setState(() {
  model.isLoading =true;
});
    List<dynamic> datas= await api.course_detail(id);
    for (var course in datas) {
      setState(() {
        model.isLoading =false;
      });
      print('Course ID: ${course['content']}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Course_detail_view(data: course['content'], attachments: course['attachments']?? [],)),

      );

    }
  }
  @override
  void initState() {
    model = MainDashboardViewModel();
    model.res_courses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return

      ChangeNotifierProvider<MainDashboardViewModel>(
          create: (context) => model,
          child: Consumer<MainDashboardViewModel>(
          builder: (context, viewModel, child) {
            return
              model.isLoading
              ? Center(child: CircularProgressIndicator(color: AppColors.primary,),):

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
                drawer: CustomSidebar(drawer: _advancedDrawerController,),
                child:  Scaffold(
                      body: SafeArea(
                        child: Column(children: [

                          Custom_App_Bar(


                            title: 'Dashboard',
                            onBackPressed: () {
                              _advancedDrawerController.showDrawer();

                            }, onNotificationPressed: () {  },


                          ),
    Text("ENROLLED COURSES", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 22, ),textAlign: TextAlign.start,),

    Expanded(
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
        itemCount: model.datalist.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
        var datas  = model.datalist[index];


        return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
        onTap: () {
          course_detail(datas.courseId);
        },// Toggle expansion on tap
        child: Container(
        decoration: BoxDecoration(
        color: const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        SizedBox(width: 10),
        Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Title
        Text(
        datas.title ,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis, // Handle overflow
        ),
        SizedBox(height: 5),
        // Body

        SizedBox(height: 5),
        // Formatted Time
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row( children:[
             Text("Author: ", style: TextStyle(fontSize: 12),),

             Text(datas.author, style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),),

           ]

           ),
            Row(
              children: [
                Icon(Icons.calendar_month , size: 13,),
                SizedBox(width: 5,),
                Text(
                  datas.enrollmentDate,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),

          ],
        ),
        ],
        ),
        ),
        SizedBox(width: 10),
        // Formatted Date

        ],
        ),
        ),
        ),
        );



        }),
      ),
    )]),),
                      ),
                    );

          }));}}
