import 'package:ess/Ess_App/generated/assets.dart';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/views/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: context.screenSize().height,
          width: context.screenSize().width,
          child: Center(
            child: Image.asset(
              Assets.imagesPremierlogo,
              height: 200,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
