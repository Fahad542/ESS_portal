import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../shared/top_app_bar.dart';
import '../../../../styles/app_colors.dart';
import '../Add_training_view_model.dart';
import 'My_training_view_model.dart';


class My_trainig_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<mytraininglviewmodel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                title: "My Training",
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: model.traininglist.length,
                    itemBuilder: (BuildContext context, index) {
                      var data = model.traininglist[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Training ${index + 1}: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,

                                      ),
                                    ),
                                    Text(data.training,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: AppColors.primary,
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => mytraininglviewmodel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
