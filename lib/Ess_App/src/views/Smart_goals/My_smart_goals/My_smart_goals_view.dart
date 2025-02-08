import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/views/Loan/See_all_loan/see_all_loan_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/api_response_models/fetch_loan_approval.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_theme.dart';
import '../Widgets/table.dart';
import 'My_smart_goals_view_model.dart';

class Mysmartgoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MYsmartgoalviewmodel>.reactive(
      builder: (viewModelContext, model, child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  GeneralAppBar(
                      title: "My Smart Goals",
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
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            table(heading: model.headings, data: model.goaldata,),
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
      viewModelBuilder: () => MYsmartgoalviewmodel(),
      onModelReady: (model) => model.init(context),
    );
  }}