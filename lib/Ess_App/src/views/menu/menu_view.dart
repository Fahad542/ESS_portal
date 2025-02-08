import 'package:ess/Ess_App/generated/assets.dart';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/menu/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  static BuildContext? _privateCtx;

  static close() {
    if (_privateCtx != null) {
      Navigator.of(_privateCtx!).pop();
    }
  }

  static open() {
    if (_privateCtx != null) {
      Scaffold.of(_privateCtx!).openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuViewModel>.reactive(
      builder: (context, model, child) {
        return SizedBox(
          width: context.screenSize().width * 0.9,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: context.screenSize().height,
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: context.screenSize().width,
                              height: 250,
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.primary,
                                      AppColors.white
                                    ],
                                  ),
                                ),
                                child: Image(
                                  image: AssetImage(Assets.imagesPremierlogo),
                                  width: context.screenSize().width - 50,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png",
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                  VerticalSpacing(5),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: model.currentUser?.userName
                                                    .toString() ??
                                                "",
                                            style: TextStyling.bold20),
                                        TextSpan(
                                          text:
                                              "(${model.currentUser?.userId.toString()})",
                                          style: TextStyling.text14.copyWith(
                                              color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        VerticalSpacing(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: model.menuItems.map((e) {
                              int index = model.menuItems
                                  .indexWhere(
                                      (element) => element.label == e.label)
                                  .toInt();
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      e.onPress();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child:
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.label,
                                            style: TextStyling.bold16.copyWith(
                                                color: AppColors.primary),
                                          ),
                                          (index != model.collapsedIndex)
                                              ? Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.primary,
                                                  size: 15,
                                                )
                                              : Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  color: AppColors.primary,
                                                  size: 25,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (index == model.collapsedIndex)
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Column(
                                        children:   e.children
                                                ?.map((en) => InkWell(
                                                      onTap: () {
                                                        en.onPress();
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              en.label,
                                                              style: TextStyling
                                                                  .text15
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.8)),),],),),)).toList() ??
                                            [],
                                      ),
                                    )
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: MainButton(
                          text: "Log Out",
                          onTap: () {
                            model.onLogout();
                          },
                          icon: Icon(
                            Icons.logout,
                            color: AppColors.white,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))))
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => MenuViewModel(context),
      onModelReady: (model) => model.init(context),
    );

  }
}



class MenuChildTileModel {
  final String title;
  final Function onTap;

  MenuChildTileModel({required this.title, required this.onTap});
}

class MenuTile extends StatefulWidget {
  final String title;
  final Function onTap;
  final bool isParent;
  final int currentIndex;
  final int collapsedIndex;
  final List<MenuChildTileModel>? children;

  const MenuTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.children,
    required this.isParent,
    required this.currentIndex,
    required this.collapsedIndex,
  }) : super(key: key);

  @override
  State<MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.onTap();
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyling.bold20.copyWith(color: AppColors.primary),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 20,
                )
              ],
            ),
          ),
        ),
        if (widget.currentIndex != widget.collapsedIndex)
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              children: widget.children
                      ?.map((e) => InkWell(
                            onTap: () {
                              widget.onTap();
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyling.bold18.copyWith(
                                        color:
                                            AppColors.primary.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList() ??
                  [],
            ),
          )
      ],
    );
  }
}
