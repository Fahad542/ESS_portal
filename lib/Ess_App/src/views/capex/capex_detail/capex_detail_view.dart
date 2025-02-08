import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/capex/capex_detail/capex_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stacked/stacked.dart';
import '../../../models/api_response_models/capex_forms.dart';

class CapexDetailView extends StatelessWidget {
  final Datalist data;

  const CapexDetailView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CapexDetailViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
                margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("#FAFAFA"),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: HexColor("#F3F3F3"),
                          ),
                        ),
                        height: 40,
                        width: 40,
                        child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.primary,
                            )),
                      ),
                    ),
                    Text(
                      "CAPEX# ${data.capexId}",
                      style: TextStyling.bold22.copyWith(color: AppColors.primary),
                    ),
                    InkWell(
                      onTap: () {
                        NavService.notification();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("#FAFAFA"),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: HexColor("#F3F3F3"),
                          ),
                        ),
                        height: 40,
                        width: 40,
                        child: Center(
                            child: Icon(
                              Icons.notifications,
                              color: AppColors.primary,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary
                ),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Requester Details",style: TextStyling.bold18.copyWith(color: AppColors.white),),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(20),
                    RichText(
                      text: TextSpan(
                        text: "Requester Name: ",
                        style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                        children: [
                          TextSpan(
                              text: data.name.toString(),
                              style: TextStyling.bold16.copyWith(color: AppColors.primary,)),
                        ],
                      ),
                    ),
                    VerticalSpacing(10),
                    RichText(
                      text: TextSpan(
                        text: "Designation: ",
                        style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                        children: [
                          TextSpan(
                              text: data.designation.toString(),
                              style: TextStyling.bold16.copyWith(color: AppColors.primary, fontSize: 16,)),
                        ],
                      ),
                    ),
                    VerticalSpacing(10),
                    RichText(
                      text: TextSpan(
                        text: "Branch / Dept: ",
                        style: TextStyling.bold16.copyWith(color: AppColors.black, fontSize: 12,),
                        children: [
                          TextSpan(
                              text: "${data.branch.toString()}/${data.dept.toString()}",
                              style: TextStyling.bold16.copyWith(color: AppColors.primary, fontSize: 16,)),
                        ],
                      ),
                    ),
                    VerticalSpacing(10),
                    RichText(
                      text: TextSpan(
                        text: "Date: ",
                        style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                        children: [
                          TextSpan(
                              text: data.capexDate.toString(),
                              style: TextStyling.bold16.copyWith(color: AppColors.primary, fontSize: 16,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacing(30),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primary
                ),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Items Details",style: TextStyling.bold18.copyWith(color: AppColors.white),),
                  ],
                ),
              ),
              VerticalSpacing(10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(color: AppColors.primary),
                  children: model.itemTableData,
                ),
              ),
              VerticalSpacing(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: context.screenSize().width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Total Due: ",
                            style: TextStyling.bold16.copyWith(color: AppColors.black, fontSize: 12,),
                            children: [
                              TextSpan(
                                  text: "Rs.0",
                                  style: TextStyling.bold16.copyWith(color: AppColors.primary, fontSize: 16,)),
                            ],
                          ),
                        ),
                        VerticalSpacing(10),
                        RichText(
                          text: TextSpan(
                            text: "SubTotal: ",
                            style: TextStyling.bold16.copyWith(color: AppColors.black, fontSize: 12,),
                            children: [
                              TextSpan(
                                  text: "Rs.${model.subtotal.toString()}",
                                  style: TextStyling.bold16.copyWith(color: AppColors.primary, fontSize: 16,)),
                            ],
                          ),
                        ),
                        Divider(color: AppColors.primary,),
                        RichText(
                          text: TextSpan(
                            text: "Total: ",
                            style: TextStyling.bold16.copyWith(color: AppColors.black, fontSize: 14,),
                            children: [
                              TextSpan(
                                  text: "Rs.${model.total.toString()}",
                                  style: TextStyling.bold16.copyWith(color: AppColors.primary, fontSize: 18,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primary
                ),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Approval History",style: TextStyling.bold18.copyWith(color: AppColors.white),),
                  ],
                ),
              ),
              VerticalSpacing(10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(color: AppColors.primary),
                  children: [
                    TableRow(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                        ),
                        children: [
                          Text("IT",style: TextStyling.bold16.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
                          Text("HOD",style: TextStyling.bold16.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
                          Text("Director",style: TextStyling.bold16.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
                        ]
                    ),
                    TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(data.approvaldetail![0].itApproval?.toUpperCase().toString() ?? "" ,style: TextStyling.text18.copyWith(color: model.colorSelection(data.approvaldetail![0].itApproval.toString()), fontSize: 14,),textAlign: TextAlign.center,),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(data.approvaldetail![0].hodApproval?.toUpperCase().toString() ?? "" ,style: TextStyling.text18.copyWith(color: model.colorSelection(data.approvaldetail![0].hodApproval.toString()), fontSize: 14,),textAlign: TextAlign.center,),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(data.approvaldetail![0].directorApproval?.toUpperCase().toString() ?? "",style: TextStyling.text18.copyWith(color: model.colorSelection(data.approvaldetail![0].directorApproval.toString()), fontSize: 14,),textAlign: TextAlign.center,),
                          ),
                        ]
                    )
                  ],
                ),
              ),
              VerticalSpacing(30),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => CapexDetailViewModel(data),
      onModelReady: (model) => model.init(),
    );
  }
}
