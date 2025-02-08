import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../My_models/final_advancce_model.dart';
import '../../base/utils/constants.dart';
import '../../services/remote/api_result.dart';
import '../../services/remote/api_service.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_theme.dart';
import '../your_attandence/widget/dropdown.dart';
import 'final_advance_approval_view_model.dart';

class final_advance extends StatefulWidget {
  const final_advance({Key? key}) : super(key: key);

  @override
  State<final_advance> createState() => _finalapprovalState();
}
List<String> dropdownValues = ["Select Status", "Approved", "Rejected"];
bool shouldShowDropdown = true;
class _finalapprovalState extends State<final_advance> {
  TextEditingController remarksController = TextEditingController();
  TextEditingController amountController = TextEditingController();


  @override

  List<TextEditingController> amountControllersList = [];

  void initState() {



    super.initState();
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<final_advance_viewmodel>.reactive(
        builder: (viewModelContext, model, child) =>
            Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            GeneralAppBar(
                                title: "Final Advance Approval",
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
                                        itemCount: model.finalapprovaldata
                                            .length,
                                        itemBuilder: (context, index) {
                                          model.selectedvisitStatusList;
                                          finalItem data = model.finalapprovaldata[index];
                                          void resetSelectedStatus(int index) {
                                            setState(() {
                                              model.selectedvisitStatusList[index] = "Select Status";
                                            });
                                          }
                                          List<TextEditingController> amountControllersList = List.generate(
                                            model.finalapprovaldata.length,
                                                (index) => TextEditingController(text: data.amount),
                                          );

                                          //value(data.amount.toString());
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
                                                                      .empName
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
                                                            text: "Post Date: ",
                                                            style: TextStyling
                                                                .text14
                                                                .copyWith(
                                                                color: AppColors
                                                                    .darkGrey),

                                                            children: [
                                                              TextSpan(
                                                                  text: data
                                                                      .postedDate
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
                                                            text: "Amount: ",
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
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize: 14,))

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



                                                        ],
                                                      ),

                                                      // SizedBox(height: 15,),
                                                      // Row(
                                                      //   children: [
                                                      //     Expanded(
                                                      //
                                                      //       child: Container(
                                                      //         height:50,
                                                      //         child: TextField(
                                                      //           controller: remarksController,
                                                      //           decoration: InputDecoration(
                                                      //             labelText: 'Remarks',
                                                      //             labelStyle:TextStyle(fontSize: 14.0, color: AppColors.primary, ),
                                                      //             hintText: 'Enter your Remarks',
                                                      //             hintStyle: TextStyle(fontSize: 12.0, color: AppColors.primary),
                                                      //             enabledBorder: OutlineInputBorder(
                                                      //               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      //               borderSide: BorderSide(color:AppColors.primary), // Border color when not focused
                                                      //             ),
                                                      //             focusedBorder: OutlineInputBorder(
                                                      //               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      //               borderSide: BorderSide(color:AppColors.primary), // Border color when focused
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //     SizedBox(width: 5,),
                                                      //     Expanded(
                                                      //
                                                      //       child: Container(
                                                      //         height:50,
                                                      //         child: TextField(
                                                      //           controller: amountControllersList[index],
                                                      //
                                                      //           decoration: InputDecoration(
                                                      //
                                                      //             labelText: 'Amount',
                                                      //            labelStyle:TextStyle(fontSize: 14.0, color: AppColors.primary, ),
                                                      //             hintText: 'Enter your Final amount',
                                                      //             hintStyle: TextStyle(fontSize: 12.0, color: AppColors.primary),
                                                      //             enabledBorder: OutlineInputBorder(
                                                      //               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      //               borderSide: BorderSide(color: AppColors.primary), // Border color when not focused
                                                      //             ),
                                                      //             focusedBorder: OutlineInputBorder(
                                                      //               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      //               borderSide: BorderSide(color: AppColors.primary), // Border color when focused
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),

                                                      buildStatusDropdown(
                                                          model
                                                              .selectedvisitStatusList[index],
                                                          // Pass the selected status for this item
                                                          dropdownValues,
                                                              (
                                                              String? newValue) async {
                                                            setState(() {
                                                              model
                                                                  .selectedvisitStatusList[index] =
                                                                  newValue; // Update the selected status for this item
                                                            });
                                                            print(model
                                                                .selectedvisitStatusList[index]);
                                                            print(
                                                                "Selected value for index $index: $newValue");
                                                            if (newValue ==
                                                                "Select Status") {
                                                              resetSelectedStatus(
                                                                  index);
                                                            }



                                                            ApiService api = ApiService();
                                                            // String amount = amountController.text;
                                                            // String remarks = remarksController.text;
                                                            String selectedBackendValue;
                                                            if (newValue == "Approved") {
                                                              selectedBackendValue = "1";
                                                            } else if (newValue == "Rejected") {
                                                              selectedBackendValue = "2";
                                                            } else {
                                                              // Handle other cases or set a default value
                                                              selectedBackendValue = "0";
                                                            }
                                                        //   if(amount.isNotEmpty)

                                                            final response = await api.finalapprovalstatus(selectedBackendValue, data.visitId
                                                                        .toString(),"","");

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
                                                                    "Approved") {
                                                                  print(
                                                                      newValue);
                                                                  Constants
                                                                      .customSuccessSnack(
                                                                      context,
                                                                      "Request is Approved");
                                                                } else
                                                                if (newValue ==
                                                                    "Rejected") {
                                                                  Constants
                                                                      .customSuccessSnack(
                                                                      context,
                                                                      "Request is Rejected");
                                                                }

                                                                if (newValue ==
                                                                    "Approved" || newValue ==
                                                                    "Rejected" ||
                                                                    status ==
                                                                        "200") {
                                                                  setState(() {
                                                                    model
                                                                        .finalapprovaldata
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



                                                          }
                                                          // else{
                                                          //   Constants.customErrorSnack(context, "Please Enter Final Amount");
                                                          //  }
                                                          }),
                                                    ]));
                                        }
                                    )
                                ))


                          ]),
                    ))),
        viewModelBuilder: () => final_advance_viewmodel(),
        onModelReady: (model) => model.init(context));
    //onModelReady: (model) => model.init(context),

  }
}

