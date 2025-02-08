import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';

class LeaveApplicationsTableData {
  final String appliedDate;
  final dynamic totalDays;
  final dynamic sick;
  final dynamic casual;
  final dynamic annual;
  final String startDate;
  final String endDate;
  final Color? statusColor;
  final String? status;

  LeaveApplicationsTableData({
    required this.appliedDate,
    required this.totalDays,
    required this.sick,
    required this.casual,
    required this.annual,
    required this.startDate,
    required this.endDate,
    this.statusColor,
    this.status,
  });
}

class LeaveApplicationsDataTable extends StatelessWidget {
  final LeaveApplicationsTableData heading;
  final List<LeaveApplicationsTableData> data;
  final ValueChanged<int> onTap;

  const LeaveApplicationsDataTable({
    Key? key,
    required this.heading,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: context.screenSize().width,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.secondary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.fromLTRB(18, 15, 18, 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: heading.appliedDate,
                        style: TextStyling.bold16
                            .copyWith(fontSize: 15, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: heading.startDate,
                        style: TextStyling.bold16
                            .copyWith(fontSize: 15, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: heading.endDate,
                        style: TextStyling.bold18
                            .copyWith(fontSize: 15, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                color: AppColors.darkGrey,
                thickness: 0.4,
              ),
            ),
            (data.length > 0)
                ? ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onTap(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    data[index].appliedDate,
                                    style: TextStyling.text14.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    data[index].startDate,
                                    style: TextStyling.text14.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    data[index].endDate,
                                    style: TextStyling.text14.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Divider(
                          color: AppColors.grey,
                          thickness: 0.4,
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Data Not Available",
                      style: TextStyling.bold18
                          .copyWith(color: AppColors.darkGrey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
