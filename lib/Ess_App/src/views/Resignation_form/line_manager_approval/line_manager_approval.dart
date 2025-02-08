import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/advance_line_manager_approval.dart';
import '../../../services/remote/api_result.dart';
import '../../../services/remote/api_service.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_theme.dart';
import '../../your_attandence/widget/dropdown.dart';
import 'line_manager_approval_view_model.dart';

class LineManager extends StatefulWidget {
  @override
  State<LineManager> createState() => _LineManagerState();
}
List<String> dropdownValues = ["Select Status", "approved", "rejected"];

class _LineManagerState extends State<LineManager> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LinemanagerViewModel>.reactive(
      builder: (viewModelContext, model, child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  GeneralAppBar(
                      title: "My Loan Applications",
                      onMenuTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      onNotificationTap: () {}),
                  (model.isBusy == true)
                      ? Center(child: CircularProgressIndicator(
                    color: AppColors.primary,))
                      : SizedBox(
                      height: context
                          .screenSize()
                          .height - 145,
                      child: ListView.builder(
                          shrinkWrap: true
                          ,
                          itemCount: model.loanlistfinal.length,
                          itemBuilder: (context, index) {
                            finalloanList data = model.loanlistfinal[index];
                            void resetSelectedStatus(int index) {
                              setState(() {
                                model.selectedvisitStatusList[index] = "Select Status";
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
                                              text: "Employee Code: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),
                                              children: [
                                                TextSpan(
                                                    text: data
                                                        .emp_code
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
                                              text: "Employee Name: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),
                                              children: [
                                                TextSpan(
                                                    text: data
                                                       .member_name
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
                                              text: "Status: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),

                                              children: [
                                                TextSpan(
                                                    text: data
                                                        .status
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
                                              text: "amount: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),

                                              children: [
                                                TextSpan(
                                                    text: data
                                                        .amount
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
                                              text: "case_date: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),

                                              children: [
                                                TextSpan(
                                                    text: data
                                                        .case_date
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
                                              text: "Case id: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),

                                              children: [
                                                TextSpan(
                                                    text: data
                                                        .case_id
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
                                                model.selectedvisitStatusList[index],
                                                dropdownValues,
                                                    (
                                                    String? newValue) async {
                                                  setState(() {
                                                    model.selectedvisitStatusList[index] = newValue!; // Update the selected status for this item
                                                  });
                                                  print(model
                                                      .selectedvisitStatusList[index]);
                                                  print(
                                                      "Selected value for index $index: $newValue");
                                                  if (newValue == "Select Status") {
                                                    resetSelectedStatus(
                                                        index);
                                                  }



                                                  ApiService api = ApiService();
                                                  final response = await api
                                                      .linemanagerapprovalstatus(
                                                      newValue!,
                                                      data.case_id
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
                                                          model.loanlistfinal
                                                              .removeAt(
                                                              index);
                                                          model.selectedvisitStatusList[index] = "Select Status";
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
                  )
                ],
              ),
            ),
          ),
      viewModelBuilder: () => LinemanagerViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
