import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Ess_App/src/styles/app_colors.dart';


class circular_bar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(child: CircularProgressIndicator(color:AppColors.primary,),),);
  }
}