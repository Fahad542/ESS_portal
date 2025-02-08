import 'dart:convert';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/services/remote/api_result.dart';
import 'package:ess/Ess_App/src/services/remote/api_service.dart';
import 'package:ess/Ess_App/src/views/your_attandence/pending_approval_view_model.dart';
import 'package:ess/Ess_App/src/views/your_attandence/widget/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../My_models/user_model.dart';
import '../../base/utils/constants.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_theme.dart';
class Pendingapproval extends StatefulWidget {
    const Pendingapproval({Key? key}) : super(key: key);

    @override
    State<Pendingapproval> createState() => _PendingapprovalState();
    }
    List<String> dropdownValues = ["Select Status", "approved", "rejected"];
    bool shouldShowDropdown = true;
    class _PendingapprovalState extends State<Pendingapproval> {
    @override
    Widget build(BuildContext context) {
      return ViewModelBuilder<Approval>.reactive(
          builder: (viewModelContext, model, child) =>
              Scaffold(
                  body: SafeArea(
                      child: Column(
                          children: [
                            GeneralAppBar(
                                title: "Pending Leave Approval",
                                onMenuTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                onNotificationTap: () {}),
                            model.isBusy
                                ? Center(child: LoadingIndicator())
                                : Center(
                                child: SizedBox(
                                    height: context
                                        .screenSize()
                                        .height - 145,
                                    child: ListView.builder(
                                        shrinkWrap: true
                                        ,
                                        itemCount: model.approvaluserdata
                                            .length,
                                        itemBuilder: (context, index) {
                                          model.selectedStatusList;
                                          ApprovalList data = model
                                              .approvaluserdata[index];
                                          void resetSelectedStatus(int index) {
                                            setState(() {
                                              model.selectedStatusList[index] = "Select Status";
                                            });
                                          }

                                          return

                                            Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                          AppColors.primary
                                                              .withOpacity(0.6),
                                                          offset: Offset(1, 1),
                                                          blurRadius: 2)
                                                    ]),
                                                margin: EdgeInsets.fromLTRB(
                                                    20, 10, 20, 5),
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 15, 10, 15),
                                                child: Column(

                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,


                                                    children: [

                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(2.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "Employee Name: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),
                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyling
                                                                      .bold14
                                                                      .copyWith(
                                                                    color: AppColors
                                                                        .primary,
                                                                    fontSize: 14,)),
                                                            ],
                                                          ),

                                                        ),
                                                      ),


                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(2.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "From Date: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),

                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .fromLeave
                                                                      .toString(),
                                                                  style: TextStyling
                                                                      .text12
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 14,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(2.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "To Date: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),

                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .toLeave
                                                                      .toString(),
                                                                  style: TextStyling
                                                                      .text12
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 14,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(2.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "No of Days: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),

                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .days
                                                                      .toString(),
                                                                  style: TextStyling
                                                                      .text12
                                                                      .copyWith(
                                                                    color: AppColors
                                                                        .primary,
                                                                    fontSize: 14,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(2.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "Reason: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),

                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .reason
                                                                      .toString(),
                                                                  style: TextStyling
                                                                      .text12
                                                                      .copyWith(
                                                                    color: AppColors
                                                                        .primary,
                                                                    fontSize: 14,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(2.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "Type: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),

                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .type
                                                                      .toString(),
                                                                  style: TextStyling
                                                                      .text12
                                                                      .copyWith(
                                                                    color: AppColors
                                                                        .primary,
                                                                    fontSize: 14,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),


                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),
                                                          ),

                                          buildStatusDropdown(
                                                              model
                                                                  .selectedStatusList[index],
                                                              // Pass the selected status for this item
                                                              dropdownValues,
                                                                  (
                                                                  String? newValue) async {
                                                                    setState(() {
                                                                      model
                                                                          .selectedStatusList[index] =
                                                                          newValue; // Update the selected status for this item
                                                                    });
                                                                    print(model
                                                                        .selectedStatusList[index]);
                                                                    print(
                                                                        "Selected value for index $index: $newValue");
                                                                    if (newValue ==
                                                                        "Select Status") {
                                                                      resetSelectedStatus(
                                                                          index);
                                                                    }



                                                                    ApiService api = ApiService();
                                                                    final response = await api
                                                                        .approvalstatus(
                                                                        newValue!,
                                                                        data.leaveid
                                                                            .toString());

                                                                    if (response is Success) {
                                                                      final jsonResponse = response
                                                                          .data;

                                                                      // Check if jsonResponse is not null and contains the "status" property
                                                                      if (jsonResponse !=
                                                                          null &&
                                                                          jsonResponse
                                                                              .containsKey(
                                                                              "status")) {
                                                                        final status = jsonResponse["status"];
                                                                        print(
                                                                            "Status: $status");

                                                                        if (newValue ==
                                                                            "approved") {
                                                                          print(
                                                                              newValue);
                                                                          Constants
                                                                              .customSuccessSnack(
                                                                              context,
                                                                              "Request is Approved");
                                                                        } else
                                                                        if (newValue ==
                                                                            "rejected") {
                                                                          Constants
                                                                              .customSuccessSnack(
                                                                              context,
                                                                              "Request is Rejected");
                                                                        }

                                                                    if (newValue ==
                                                                        "approved" || newValue ==
                                                                            "rejected" ||
                                                                        status ==
                                                                            "200") {
                                                                      setState(() {
                                                                        model
                                                                            .approvaluserdata
                                                                            .removeAt(
                                                                            index);
                                                                        model.selectedStatusList[index] = "Select Status";
                                                                      });
                                                                    }
                                                                    } else {
                                                                      // Handle the case where jsonResponse is null or "status" is missing
                                                                      print(
                                                                          "JSON response is null or 'status' is missing");
                                                                    }


                                                                  }}),


                                                        ],
                                                      ),


                                                    ]));
                                        }
                                    )
                                ))


                          ]))),
          viewModelBuilder: () => Approval(),
          onModelReady: (model) => model.init(context));
      //onModelReady: (model) => model.init(context),

    }
    }

