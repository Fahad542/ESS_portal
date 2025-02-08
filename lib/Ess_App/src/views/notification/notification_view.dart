import 'package:ess/Ess_App/generated/assets.dart';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/notification/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stacked/stacked.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 18, left: 18, right: 18,),
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
                              Icons.arrow_back_ios_new,
                              color: AppColors.primary,
                            )),
                      ),
                    ),
                    Text(
                      "Notification",
                      style: TextStyling.bold22.copyWith(color: AppColors.primary),
                    ),
Text("")

                  ],
                ),
              ),
              model.list.isEmpty ?
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: context.screenSize().height - 110,
                width: context.screenSize().width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesNothingHere,
                      height: 200,
                    ),
                    VerticalSpacing(),
                    Text("Data Not Available", style: TextStyling.bold18.copyWith(color: AppColors.primary),)
                  ],
                ),
              ) : Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                    itemCount:model.list.length ,
                    itemBuilder: (BuildContext context, index)
                    {
                      var  data=model.list[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green), // Attendance icon
                                  SizedBox(width: 10), // Space between icon and text
                                  Expanded(
                                    child: Text("Your Attendance has been marked"
                                      ,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Text( data['date'],style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)

                                ],
                              ),
                              SizedBox(height: 8,),
                              Container(
                                alignment: Alignment.centerLeft, // Start alignment
                                child: Text(
                                  "${data['time']} AM",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),

                              // Text("Latitude: ${data['target_lat']}"),
                              // Text("Longtitude: ${data['target_long']}"),
                              // Text("Target Latitude: ${data['lat']}"),
                              // Text("Target Longtitude: ${data['long']}")
                            ],
                            
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
