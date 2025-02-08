import 'package:ess/Ess_App/generated/assets.dart';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

class AttendenceTableData {
  final String date;
  final DateTime formetedDate;
  final String checkIn;
  final String? day;
  final String checkOut;
  final Color? statusColor;
  final String? Attendstatus;


  AttendenceTableData(
      {
    required this.date,
         this.day,
    required this.checkIn,
    required this.formetedDate,
    required this.checkOut,
    required this.Attendstatus,
    this.statusColor,
  }
  );
}

class AttendenceDataTable extends StatelessWidget {
  final AttendenceTableData heading;
  final List<AttendenceTableData> data;
  final bool wantHeader;
  final ValueChanged<AttendenceTableData> onTap;

  const AttendenceDataTable({
    Key? key,
    required this.heading,
    required this.data,
    this.wantHeader = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: context.screenSize().width,
        decoration: BoxDecoration(
          //color: AppColors.grey.withOpacity(0.1),
          color: AppColors.white,
          border: Border.all(color: AppColors.secondary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.fromLTRB(18, 15, 18, 10),
        child: Column(
          children: [
            if (wantHeader)
              Container(
                width: context.screenSize().width,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: Text(
                    "Your Attendence",
                    style: TextStyling.bold20.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            Container(
              color: AppColors.primary,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Container(

                  //color: AppColors.secondary.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: heading.date,
                            style: TextStyling.bold14
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: heading.checkIn,
                            style: TextStyling.bold14
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: heading.checkOut,
                            style: TextStyling.bold14
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          Assets.imagesIndexFinger,
                          height: 24,
                          width: 24,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: Divider(
            //     color: AppColors.darkGrey,
            //     thickness: 0.4,
            //   ),
            // ),
            (data.length > 0)
                ? ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        enabled: (data[index].statusColor == Colors.orange),
                        key: ValueKey(data[index].date.toString()),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 2,
                              onPressed: (_) {
                                onTap(data[index]);
                              },
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              label: 'Apply Leave',
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data[index].date,
                                    style: TextStyling.text14.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data[index].checkIn,
                                    style: TextStyling.text14.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data[index].checkOut,
                                    style: TextStyling.text14.copyWith(
                                        color: data[index].statusColor ??
                                            AppColors.primary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                (data[index].statusColor == Colors.orange)
                                    ? Expanded(
                                        flex: 1,
                                        child: Lottie.asset(
                                            Assets.imagesSwapLottie),
                                      )
                                    : Expanded(
                                        flex: 1,
                                        child: Image.asset(
                                          Assets.imagesIndexFinger,
                                          height: 24,
                                          width: 24,
                                          color: Colors.transparent,
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
