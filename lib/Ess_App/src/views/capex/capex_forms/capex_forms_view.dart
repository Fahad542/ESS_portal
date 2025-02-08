import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/configs/app_setup.router.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/shared/loading_indicator.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/capex/capex_forms/capex_forms_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/api_response_models/capex_forms.dart';
import '../../dashboard/widget/title_widget.dart';

class CapexFormsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CapexFormsViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "All Capex Forms",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleWidget(title: "Approved", color: Colors.green),
                    TitleWidget(title: "Pending", color: Colors.orange),
                    TitleWidget(title:"Rejected", color:Colors.red),
                  ],
                ),
              ),
              VerticalSpacing(5),
              model.isBusy
                  ? Center(child: LoadingIndicator())
                  : SizedBox(
                      height: context.screenSize().height - 145,
                      child: ListView.builder(
                          itemCount: model.capexForms.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Datalist data = model.capexForms[index];
                            double totalAmount = 0.0;
                            data.itemdetail?.forEach((element) {
                              totalAmount += (double.parse(element.price.toString()) * double.parse(element.qty.toString()));
                            });
                            return InkWell(
                              onTap: (){
                                NavService.capexDetail(arguments: CapexDetailViewArguments(data: data));
                              },
                              child: Container(
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.name.toString(), style: TextStyling.bold18,),
                                        Text("Rs.${totalAmount.round().toString()}", style: TextStyling.bold20.copyWith(color: AppColors.primary, fontSize: 16,),),
                                      ],
                                    ),
                                    VerticalSpacing(20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Capex Id: ",
                                            style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                            children: [
                                              TextSpan(
                                                  text: data.capexId.toString(),
                                                  style: TextStyling.bold18.copyWith(
                                                      color: AppColors.primary, fontSize: 16,)),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: "Status: ",
                                            style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                            children: [
                                              TextSpan(
                                                  text: data.capexStatus.toString(),
                                                  style: TextStyling.bold18.copyWith(
                                                      color: model.colorSelection(data.capexStatus?.toLowerCase() ?? ""), fontSize: 16,)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalSpacing(15),
                                    RichText(
                                      text: TextSpan(
                                        text: "Submitted On: ",
                                        style: TextStyling.text14.copyWith(color: AppColors.darkGrey),
                                        children: [
                                          TextSpan(
                                              text: data.capexDate.toString(),
                                              style: TextStyling.bold18.copyWith(
                                                  color: AppColors.primary, fontSize: 16,)),
                                        ],
                                      ),
                                    ),
                                    VerticalSpacing(10),
                                    Divider(color: AppColors.primary, thickness: 0.5, indent: 20, endIndent: 20,),
                                    VerticalSpacing(5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: context.screenSize().width - 90,
                                          child: RichText(
                                            text: TextSpan(
                                              text: data.designation.toString(),
                                              style: TextStyling.text14,
                                              children: [
                                                TextSpan(
                                                    text: "-${data.branch.toString()}",
                                                    style: TextStyling.bold18.copyWith(
                                                      fontSize: 14,
                                                        color: AppColors.primary)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.remove_red_eye_outlined, color: AppColors.secondary,)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                      ),
                  ),
              ],
          ),
        ),
      ),
      viewModelBuilder: () => CapexFormsViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }

  Widget _getTitleWidget(String title, Color color) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          height: 16,
          width: 16,
        ),
        HorizontalSpacing(5),
        Text(
          title,
          style: TextStyling.text16.copyWith(color: color),
        )
      ],
    );
  }
}
