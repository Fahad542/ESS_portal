import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/api_response_models/Loan_history_hod_model.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import 'Loan_history_view_model.dart';

class Loan_history extends StatefulWidget {
  @override
  State<Loan_history> createState() => _Pending_guaranteesState();
}

class _Pending_guaranteesState extends State<Loan_history> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<loan_history_view_model>.reactive(
      builder: (viewModelContext, model, child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  GeneralAppBar(
                      title: "Loan History For HOD",
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
                            LoanForm data = model.loanlistfinal[index];
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                               Text("Loan Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),),
                                  SizedBox(height: 10,),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Mr. ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: data.empName,
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: ' has applied for the loan of ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: "",
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'Designation: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: "${data.position}\n",
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Date of joining: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${data.doj}\n',
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'Loan Type: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${data.loanType}\n\n',
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'He will repay the loan in ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${data.totalInstallment}',
                                          style: TextStyle(color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                TextSpan(
                                  text: ' equal installment of ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '${data.loanAmount} Rs',
                                  style: TextStyle(color: Colors.blue,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                TextSpan(
                                  text: ' and need your approval for futher proceedings',
                                  style: TextStyle(color: Colors.black),
                                ),


                                      ],
                                    ),
                                  ),
                                    SizedBox(height: 10,),
                                    Text("Account Detail and Approval", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),),
                                    SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Text(data.status, style: TextStyle(color: Colors.white),)),
                                    SizedBox(height: 10,),
                                    Text("Action", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),),
                                    SizedBox(height: 10,),
                            RichText(
                            text: TextSpan(
                            children: [
                            TextSpan(
                            text: 'HOD Status: ',
                            style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                            text: "${data.hodStatus}\n",
                            style: TextStyle(color: Colors.blue,
                            fontWeight: FontWeight.bold),
                            ),
                              TextSpan(
                                text: 'Director Status: ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text:  "${data.directorStatus}\n",
                                style: TextStyle(color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'CEOStatus: ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "${data.ceoStatus}\n",
                                style: TextStyle(color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                               
                              ),
                              
                            ])),
                                   if(data.empShare.isNotEmpty)
                                    Text("Emp Share: ${data.empShare}" ),
                                    if (data.cmpShare.isNotEmpty)
                                      Text("Cmp Share: ${data.cmpShare}" ),
                                    if (data.prvBalance.isNotEmpty)
                                      Text("Prv Share: ${data.prvBalance}")

                                  ],),
                              );
                          }
                      )
                  )
                ],
              ),
            ),
          ),
      viewModelBuilder: () => loan_history_view_model(),
      onModelReady: (model) => model.init(context),
    );
  }
}