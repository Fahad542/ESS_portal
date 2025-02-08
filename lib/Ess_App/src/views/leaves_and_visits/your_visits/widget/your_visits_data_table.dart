import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';

class VisitsTableData {
  final String location;
  final String reason;
  final String appliedDate;
  final String visitsDate;
  final Color statusColor;
  final String status;
  final String approvedBy;

  VisitsTableData({
    required this.location,
    required this.reason,
    required this.approvedBy,
    required this.appliedDate,
    required this.visitsDate,
    required this.statusColor,
    required this.status,
  });
}

class VisitsDataTable extends StatelessWidget {
  final VisitsTableData heading;
  final List<VisitsTableData> data;
  final ValueChanged<int> onTap;

  const VisitsDataTable({
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
                    flex: 3,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: heading.visitsDate,
                        style: TextStyling.bold18
                            .copyWith(fontSize: 16, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: heading.reason,
                        style: TextStyling.bold18
                            .copyWith(fontSize: 16, color: AppColors.primary),
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
                                  flex: 3,
                                  child: Text(
                                    data[index].visitsDate,
                                    style: TextStyling.text16.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data[index].reason,
                                    style: TextStyling.text16.copyWith(
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
