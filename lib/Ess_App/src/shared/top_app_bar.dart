import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../generated/assets.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/menu/menu_view.dart';

class HomeAppBar extends StatelessWidget {
  final String name;
  final Function onMenuTap;
  final Function onNotificationTap;

  const HomeAppBar(
      {Key? key,
        required this.name,
        required this.onMenuTap,
        required this.onNotificationTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [

          Positioned(
            top: 0, // यह header को सबसे ऊपर ले जाएगा
            left: 0,
            right: 0,
            child: Container(
              height: 110,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                  padding: EdgeInsets.only(bottom: 10, left: 18, right: 18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
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
                                        Icons.menu,
                                        color: AppColors.primary,
                                      )),
                                ),
                              ),
                              HorizontalSpacing(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Assalam o alaikum",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  Text(
                                    name,
                                    style: TextStyling.bold22.copyWith(
                                        color: AppColors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              onNotificationTap();
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
                                    Icons.access_time,
                                    color: AppColors.primary,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 70, // इसे और ऊपर लाने के लिए top value घटाएं
          //   left: 0,
          //   right: 0,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: [
          //           leavesCart("Annual Leaves", '0', Assets.imagesAnnual),
          //           SizedBox(width: 10),
          //           leavesCart("Casual Leaves", '0', Assets.imagesCasual),
          //           SizedBox(width: 10),
          //           leavesCart("Sick Leaves", '0', Assets.imagesSick),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );

  }
}


class GeneralAppBar extends StatelessWidget {
  final String title;
  final Function onMenuTap;
  final Function onNotificationTap;

  const GeneralAppBar(
      {Key? key,
      required this.title,
      required this.onMenuTap,
      required this.onNotificationTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
      margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onMenuTap();
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
                Icons.menu,
                color: AppColors.primary,
              )),
            ),
          ),
          Text(
            title,
            style: TextStyling.bold22.copyWith(color: AppColors.primary),
          ),
          InkWell(
            onTap: () {
              NavService.notification();
              onNotificationTap();
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
    );
  }
}



class AppBarwidget extends StatelessWidget {
  final String title;
  final Function onMenuTap;
  final Function onNotificationTap;

  const AppBarwidget(
      {Key? key,
        required this.title,
        required this.onMenuTap,
        required this.onNotificationTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Icons.arrow_back,
                    color: AppColors.primary,
                  )),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Text(
              title,
              style: TextStyling.bold20.copyWith(color: AppColors.primary),
            ),
          ),
          
        ],
      ),
    );
  }
}

