import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../../Ess_App/src/styles/app_colors.dart';
import '../../Components/Drawer.dart';
import '../../Components/Lms_home_page_appbar.dart';

class Aboutus extends StatefulWidget {
  const Aboutus();

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus>

{
  final DrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return
      AdvancedDrawer(
        backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, Colors.black],
    ),
    ),
    ),
    controller: DrawerController,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 300),
    animateChildDecoration: true,
    rtlOpening: false,
    disabledGestures: false,
    childDecoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
      drawer: CustomSidebar(drawer: DrawerController,),
      child:
      SafeArea(
        child:
       Scaffold(
         body:
         Column(children: [
           general_bar(
            title: "About us",
            context: context,
            adcontroller: DrawerController,
          ),





        ],),
      ),
      ) );
  }
}
