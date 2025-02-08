
import 'package:ess/Ess_App/src/views/Advance/request_advance_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../base/utils/constants.dart';
import '../../shared/bottons.dart';
import '../../shared/input_field.dart';
import '../../shared/spacing.dart';
import '../../shared/top_app_bar.dart';

class requestadvance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final isBefore15th = currentDate.day <= 15;

    return ViewModelBuilder<requestadvanceViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                title: "Request Advance",
                onMenuTap: () {
                  Scaffold.of(context).openDrawer();
                },
                onNotificationTap: () {},
              ),
              if (isBefore15th)
                Expanded(
                  child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(
                            "Advance Facility Will Be Enable After 15th Of Every Month",
                            style: TextStyle(fontSize: 18, ),
                          ),


                    ),

                )
              else
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Form(
                        child: Builder(
                          builder: (ctx) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondInputField(
                                  label: 'Advance Amount',
                                  hint: 'Enter Amount',
                                  controller: model.Advance_amount,
                                  inputType: TextInputType.text,
                                  onTap: () {},
                                  message: 'Please enter employee code',
                                ),
                                VerticalSpacing(20),
                                SecondInputField(
                                  label: 'Reason',
                                  hint: 'Enter Reason',
                                  controller: model.Reason,
                                  inputType: TextInputType.text,
                                  onTap: () {},
                                  message: 'Please enter employee name',
                                ),
                                VerticalSpacing(20),
                                MainButton(
                                  text: "Apply",
                                  isBusy: model.isBusy,
                                  onTap: () {
                                    if (model.Advance_amount.text.isNotEmpty &&
                                        model.Reason.text.isNotEmpty) {
                                      model.applyrequest_advanced(context);
                                    } else {

                                      Constants.customErrorSnack(context, "Please fill in all fields");
                                    }
                                  },
                                ),
                                VerticalSpacing(20),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => requestadvanceViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
