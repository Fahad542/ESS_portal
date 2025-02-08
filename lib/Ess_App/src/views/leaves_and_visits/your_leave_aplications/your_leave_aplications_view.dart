import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/loading_indicator.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_leave_aplications/widget/leave_aplications_data_table.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_leave_aplications/your_leave_aplications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../dashboard/widget/title_widget.dart';

class LeaveApplicationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaveApplicationsViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Leave Applications",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleWidget(title:"Approved", color:Colors.green),
                    TitleWidget(title: "Pending",color: Colors.orange),
                    TitleWidget(title:"Rejected", color:Colors.red),
                  ],
                ),
              ),
              VerticalSpacing(5),
              model.isBusy
                  ? Center(child: LoadingIndicator())
                  : SizedBox(
                      height: context.screenSize().height - 145,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            LeaveApplicationsDataTable(
                              heading: model.heading,
                              data: model.data,
                              onTap: (int index) {
                                var selectedData = model.data[index];
                                showLeaveApplication(context, selectedData);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LeaveApplicationsViewModel(),
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

  void showLeaveApplication(
      BuildContext context, LeaveApplicationsTableData data) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: context.screenSize().width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Applied On: ',
                          style: TextStyling.bold18
                              .copyWith(color: AppColors.primary),
                          children: <TextSpan>[
                            TextSpan(
                              text: data.appliedDate,
                              style: TextStyling.bold18
                                  .copyWith(color: AppColors.secondary),
                            )
                          ]),
                    ),
                    VerticalSpacing(20),
                    RichText(
                      text: TextSpan(
                          text: 'Leave Start At: ',
                          style: TextStyling.bold18
                              .copyWith(color: AppColors.primary),
                          children: <TextSpan>[
                            TextSpan(
                              text: data.startDate,
                              style: TextStyling.bold18
                                  .copyWith(color: AppColors.secondary),
                            )
                          ]),
                    ),
                    VerticalSpacing(10),
                    RichText(
                      text: TextSpan(
                          text: 'Leave End At: ',
                          style: TextStyling.bold18
                              .copyWith(color: AppColors.primary),
                          children: <TextSpan>[
                            TextSpan(
                              text: data.endDate,
                              style: TextStyling.bold18
                                  .copyWith(color: AppColors.secondary),
                            )
                          ]),
                    ),
                    VerticalSpacing(20),
                    RichText(
                      text: TextSpan(
                          text: 'Number of Days: ',
                          style: TextStyling.bold18
                              .copyWith(color: AppColors.primary),
                          children: <TextSpan>[
                            TextSpan(
                              text: data.totalDays.toString(),
                              style: TextStyling.bold18
                                  .copyWith(color: AppColors.secondary),
                            )
                          ]),
                    ),
                    VerticalSpacing(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Sick",
                              style: TextStyling.bold20
                                  .copyWith(color: AppColors.primary),
                            ),
                            VerticalSpacing(5),
                            Text(
                              data.sick.toString(),
                              style: TextStyling.bold20
                                  .copyWith(color: AppColors.secondary),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Casual",
                              style: TextStyling.bold20
                                  .copyWith(color: AppColors.primary),
                            ),
                            VerticalSpacing(5),
                            Text(
                              data.casual.toString(),
                              style: TextStyling.bold20
                                  .copyWith(color: AppColors.secondary),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Annual",
                              style: TextStyling.bold20
                                  .copyWith(color: AppColors.primary),
                            ),
                            VerticalSpacing(5),
                            Text(
                              data.annual.toString(),
                              style: TextStyling.bold20
                                  .copyWith(color: AppColors.secondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    VerticalSpacing(30),
                    FittedBox(
                        child: Text(
                      data.status.toString(),
                      style: TextStyling.extraBold24
                          .copyWith(color: data.statusColor),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
