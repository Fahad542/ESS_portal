import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/views/Loan/See_all_loan/see_all_loan_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/api_response_models/fetch_loan_approval.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_theme.dart';

class Allloan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllLoanViewModel>.reactive(
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
                            loanList data = model.loanlistfinal[index];


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
                                                        .emp_name
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
                                              text: "loan Amount: ",
                                              style: TextStyling
                                                  .text14
                                                  .copyWith(
                                                  color: AppColors
                                                      .darkGrey),

                                              children: [
                                                TextSpan(
                                                    text: data
                                                        .loan_amount
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
                                            Text(""),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Loan Details', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                                      contentPadding: EdgeInsets.all(8), // Padding around the content
                                                      content: Column(
                                                        mainAxisSize: MainAxisSize.min, // Use min to reduce dialog size
                                                        children: [
                                                          SizedBox(height: 8), // Add gap
                                                          Text('Designation: ${data.position}'),

                                                          SizedBox(height: 8), // Add gap
                                                          Text('Loan Type: ${data.loantype}'),// Add gap
                                                          Text('Date of joining: ${data.doj}'),
                                                          SizedBox(height: 8), // Add gap
                                                          Text('Total Installment: ${data.total_installment}'),
                                                          SizedBox(height: 8), // Add gap
                                                          Text('Per Month Repay: ${data.per_month_repay}'),
                                                          SizedBox(height: 8), // Add gap
                                                          Text('HOD Status: ${data.hod_status}'),
                                                          SizedBox(height: 8), // Add gap
                                                          Text('Director Status: ${data.director_status}'),
                                                          SizedBox(height: 8), // Add gap
                                                          Text('CEO Status: ${data.ceo_status}'),
                                                          SizedBox(height: 8),
                                                          Text('Reason: ${data.purpose}'),
                                                          SizedBox(height: 8), //// Add gap
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('Close'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.primary, // Use your desired color here
                                                ),
                                                child: Text(
                                                  "See Details",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            )

                                          ],
                                        )
                                      ]));
                          }
                      )
                  )
                ],
              ),
            ),
          ),
      viewModelBuilder: () => AllLoanViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }}