import 'package:ess/Ess_App/src/views/Whistle_blowing/whistle_blowing_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../base/utils/constants.dart';
import '../../shared/bottons.dart';
import '../../shared/input_field.dart';
import '../../shared/spacing.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../Loan/customtextfeild.dart';

class WhistleBlowingview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WhistleblowingViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Whistle Blowing",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {
                  }),
              (model.isBusy == true)
                  ? Center(child: CircularProgressIndicator(color: AppColors.primary,))
                  : Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Text("Points to Consider:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Text(
                          '1- The identity of the whistleblower will be kept confidential and will not be revealed to anyone.',
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '2- Please only blow the whistle if it is highly needed.',
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '3- Please make use of this opportunity responsibly.',
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '4- In case of spreading false information or character assassination of any employee, the whistleblower will be reprimanded.',
                        ),                        SizedBox(height: 20,),
                      CustomTextField(
                        controller: model.titlecontroller,
                        labelText: 'Issue Title',
                      ),
                      SizedBox(height: 20,),
                      message(
                        controller: model.detailcontroller,
                        labelText: 'Write an issue',
                      ),
                      SizedBox(height: 30,),
                        MainButton(
                            text: "Summit",
                            isBusy: model.isBusy,
                            onTap: () {
                              if (model.titlecontroller.text.isNotEmpty &&
                                  model.detailcontroller.text.isNotEmpty) {
                                model.applywhistle(context);
                              } else {
                                Constants.customErrorSnack(context, "Please fill in all fields");
                              }
                            }),
                    ],)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => WhistleblowingViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
