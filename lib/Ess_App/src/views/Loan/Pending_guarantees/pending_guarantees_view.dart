import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/views/Loan/Pending_guarantees/pending_gurantees_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/pending_guaranted.dart';
import '../../../services/remote/api_result.dart';
import '../../../services/remote/api_service.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../your_attandence/widget/dropdown.dart';

class Pending_guarantees extends StatefulWidget {
  @override
  State<Pending_guarantees> createState() => _Pending_guaranteesState();
}

class _Pending_guaranteesState extends State<Pending_guarantees> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<guarantees_view_model>.reactive(
      builder: (viewModelContext, model, child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  GeneralAppBar(
                      title: "Pending Guarantees",
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
                            Pending data = model.loanlistfinal[index];
                            void resetSelectedStatus(int index) {
                              setState(() {
                                model.selectedvisitStatusList[index] =
                                "Select your decision";
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
                                child: Column(children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Mr. ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: data.empName.toString(),
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: ' has applied for the loan of ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${data.loan} Rs (${data
                                              .loanInWords} in words) ',
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: ' and assigned you as his ${data
                                              .guarantor} Guarantor. He will repay the loan in ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: data.repay,
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' equal installments of ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${data.repayRs} Rs',
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: '. Are you taking his guarantee?',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      buildStatusDropdown(
                                        model.selectedvisitStatusList[index],
                                        model.dropdownValues,
                                            (String? newValue) async {
                                          setState(() {
                                            model.selectedvisitStatusList[index] = newValue; // Update the selected status for this item
                                          });
                                          print(model.selectedvisitStatusList[index]);
                                          print("Selected value for index $index: $newValue");

                                          // Check if the selected value is "Select your decision"
                                          if (newValue == "Select your decision") {
                                            resetSelectedStatus(index);
                                            return; // Exit the function early, skipping the API call
                                          }

                                          ApiService api = ApiService();
                                          String selectedBackendValue;
                                          if (newValue == "I Guratranteed !") {
                                            selectedBackendValue = "1";
                                          } else if (newValue ==
                                              "I Wont be responsible") {
                                            selectedBackendValue = "2";
                                          } else {
                                            selectedBackendValue =
                                            "0"; // Default value for other cases
                                          }

                                          final response = await api
                                              .approved_pending_guarantor(
                                            selectedBackendValue,
                                            data.loanId.toString(),
                                            data.guarantor.toString(),
                                          );

                                          if (response is Success) {
                                            final jsonResponse = response.data;

                                            if (jsonResponse != null &&
                                                jsonResponse.containsKey(
                                                    "status")) {
                                              final status = jsonResponse["status"];
                                              final msg = jsonResponse['status_message'];
                                              print("Status: $status");

                                              if (newValue ==
                                                  "I Guratranteed !") {
                                                Constants.customSuccessSnack(
                                                    context, msg);
                                              } else if (newValue ==
                                                  "I Wont be responsible") {
                                                Constants.customSuccessSnack(
                                                    context, msg);
                                              }

                                              if (newValue ==
                                                  "I Guratranteed !" ||
                                                  newValue ==
                                                      "I Wont be responsible" ||
                                                  status == "200") {
                                                setState(() {
                                                  if(model.selectedvisitStatusList != "Select your decision")

                                                  model.loanlistfinal.removeAt(
                                                      index);
                                                  model
                                                      .selectedvisitStatusList[index] =
                                                  "Select your decision";
                                                });
                                              }
                                            } else {
                                              print(
                                                  "JSON response is null or 'status' is missing");
                                            }
                                          }
                                        },
                                      )

                                    ],
                                  ),
                                ],),
                              );
                          }
                      )
                  )
                ],
              ),
            ),
          ),
      viewModelBuilder: () => guarantees_view_model(),
      onModelReady: (model) => model.init(context),
    );
  }}