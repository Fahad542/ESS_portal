import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import '../../../base/utils/constants.dart';
import '../../../shared/bottons.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../Loan/customsearchabledropdown.dart';
import '../../Loan/customtextfeild.dart';
import 'Edit_smart_goal_view_model.dart';

class Editsmartgoals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Editsmartgoalviewmodel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                title: "Add Smart Goals",
                onMenuTap: () {
                  Scaffold.of(context).openDrawer();
                },
                onNotificationTap: () {},
              ),
              (model.isBusy)
                  ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ))
                  : Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'You have already filled ${model.weightage}% of your Goals.',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomSearchableDropDown(
                          items: model.batch,
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
                          dropDownMenuItems: model.batch .map((item) => item.batch)
                              .toList(),
                          onChanged: (value) {
                            FocusScope.of(context).unfocus();
                            if (value != null) {
                              model.selectedValue = value.id.toString();
                              model.notifyListeners();
                              print("Selected value: ${model.selectedValue}");
                            }
                          },
                        ),

                        SizedBox(height: 10),
                        CustomTextField(
                          controller: model.smart_goal,
                          labelText: 'Smart Goal',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: model.goal_detail,
                          labelText: 'Goal Detail',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: model.measures,
                          labelText: 'Measures',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: model.weightageinpercentage,
                          labelText: 'Weightage In Percentage%',
                          inputType: TextInputType.number,
                          formatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(RegExp(r'[.,-]')),
                          ],

                        ),
                        SizedBox(height: 20),
                        MainButton(
                          text: "Add Smart goal",
                          isBusy: model.isBusy,
                          onTap: () async {
                                double weightageValue = double.tryParse(model.weightage) ?? 0.0;
    double weightageInPercentageValue = double.tryParse(model.weightageinpercentage.text) ?? 0.0;
                                double weightageInPercentageValues = double.tryParse(model.weightageinpercentage.text) ?? 0.0;

                                double totalSum = weightageValue + weightageInPercentageValue;
    model.sum = totalSum.toString();
    model.notifyListeners();
                                if (weightageInPercentageValue < 1 || weightageInPercentageValue > 100 ) {
                                  Constants.customErrorSnack(context, 'Weightage should be between 1 and 100, without commas or decimal points');
                                  return;
                                }

                                if (
                            model.selectedValue!=null &&
                                model.smart_goal.text.isNotEmpty &&
                                model.goal_detail.text.isNotEmpty &&
                                model.measures.text.isNotEmpty &&
                                model.weightageinpercentage.text.isNotEmpty)
                            {
                              if(totalSum < 0  ||totalSum <= 100)
                                {
                                    await model.addgoal(context);
                                }
                              else {
                                Constants.customErrorSnack(context, 'You Reach Maximum number of Weightage');
                              }
                            }
                            else {

                              Constants.customErrorSnack(context, 'Please fill all fields');
                            }
                            model.notifyListeners();
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
      viewModelBuilder: () => Editsmartgoalviewmodel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
