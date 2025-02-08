import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/configs/app_setup.router.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/shared/loading_indicator.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/your_attandence/widget/Attendance_widget.dart';
import 'package:ess/Ess_App/src/views/your_attandence/widget/attendence_data_table.dart';
import 'package:ess/Ess_App/src/views/your_attandence/your_attandence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../dashboard/widget/title_widget.dart';

class YourAttendanceView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<YourAttendanceViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Attendance",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         TitleWidget(title: "Late", color: Colors.red),
              //         SizedBox(width: 5,),
              //         TitleWidget(title:"Absent", color: Colors.orange),
              //         SizedBox(width: 5,),
              //         TitleWidget(title:"On Time",color: Colors.green),
              //         SizedBox(width: 5,),
              //         TitleWidget(title:"Weekend",color: AppColors.primary),
              //         SizedBox(width: 5,),
              //         TitleWidget(title:"Haft Day",color: AppColors.black),
              //       ],
              //     ),
              //   ),
              // ),
              VerticalSpacing(5),
              model.isBusy
                  ? Center(child: LoadingIndicator())
                  : SizedBox(
                      height: context.screenSize().height - 145,
                      child:
                      AttendanceScreen(data: model.data,)
                      // SingleChildScrollView(
                      //   physics: BouncingScrollPhysics(),
                      //   child: Column(
                      //     children: [
                      //       AttendenceDataTable(
                      //         heading: model.heading,
                      //         data: model.data,
                      //         onTap: (AttendenceTableData value) {
                      //           NavService.applyLeave(arguments: ApplyLeaveViewArguments(date: value.formetedDate.toString()));
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => YourAttendanceViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }

  Widget _getTitleWidget(String title, Color color) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          height: 16,
          width: 16,
        ),
        HorizontalSpacing(5),
        Text(
          title,
          style: TextStyling.text16.copyWith(color: color),
        )
      ],
    );
  }
}
