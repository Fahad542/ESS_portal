import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../shared/bottons.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../Loan/customsearchabledropdown.dart';
import '../../Loan/customtextfeild.dart';
import 'Add_training_view_model.dart';

class Add_trainig_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<traininglviewmodel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                title: "Add Training Needs",
                onMenuTap: () {
                  Scaffold.of(context).openDrawer();
                },
                onNotificationTap: () {},
              ),
              model.isBusy
                  ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
                  : Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Training 1', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,)
                          ],
                        ),
                        CustomSearchableDropDown(
                          items: model.traininglist,
                          label: model.selectedValue,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: const Color(0xff3E4684)),
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(Icons.search),
                          ),
                          dropDownMenuItems: model.traininglist
                              .map((item) => item.trainings)
                              .toList(),
                          onChanged: (value) {
                            FocusScope.of(context).unfocus();

                            if (value != null) {

                              model.selectedValue = value.trainings.toString();
                              model.notifyListeners();
                              print("Selected value: ${model.selectedValue}");
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Training 2', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,)
                          ],
                        ),
                        CustomTextField(
                          controller: model.training,
                          labelText: 'Training 2',
                        ),
                        SizedBox(height: 20),
                        MainButton(
                          text: "Add Training",
                          isBusy: model.isBusy,
                          onTap: () {
                            if(model.selectedValue!=null && model.training!=null) {
                             model.summit(context);}
                            else {
                              Constants.customErrorSnack(context,'Please fill all feilds');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => traininglviewmodel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
