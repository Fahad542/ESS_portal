import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/models/api_response_models/all_reservation.dart';
import 'package:ess/Ess_App/src/shared/loading_indicator.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/reservation/all_reservations/all_reservations_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AllReservationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllReservationsViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "All Reservations",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}),
              model.isBusy
                  ? Center(child: LoadingIndicator())
                  : SizedBox(
                      height: context.screenSize().height - 145,
                      child: ListView.builder(
                        itemCount: model.reservationData.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          ReservationDatalist data = model.reservationData[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                      AppColors.primary.withOpacity(0.6),
                                      offset: Offset(1, 1),
                                      blurRadius: 2)
                                ]),
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.boardRoom.toString(), style: TextStyling.bold18,),
                                VerticalSpacing(20),
                                RichText(
                                  text: TextSpan(
                                    text: "Reserve Date: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.reserveDate.toString(),
                                          style: TextStyling.bold14.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                                RichText(
                                  text: TextSpan(
                                    text: "Reserve Time: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.reserveTime.toString(),
                                          style: TextStyling.bold14.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                                RichText(
                                  text: TextSpan(
                                    text: "booked By: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.bookBy.toString(),
                                          style: TextStyling.bold18.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                                RichText(
                                  text: TextSpan(
                                    text: "No of People: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.noOfPeople.toString(),
                                          style: TextStyling.bold18.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                                RichText(
                                  text: TextSpan(
                                    text: "Agenda: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.agenda.toString(),
                                          style: TextStyling.bold18.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                                RichText(
                                  text: TextSpan(
                                    text: "Status: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.eventStatus.toString(),
                                          style: TextStyling.bold18.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                                RichText(
                                  text: TextSpan(
                                    text: "Remarks: ",
                                    style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                    children: [
                                      TextSpan(
                                          text: data.remarks.toString(),
                                          style: TextStyling.bold18.copyWith(
                                            color: AppColors.primary, fontSize: 14,)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(10),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AllReservationsViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
