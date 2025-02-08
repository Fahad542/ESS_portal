import 'package:connectivity/connectivity.dart';
import 'package:ess/Ess_App/generated/assets.dart';
import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:ess/Ess_App/src/views/menu/menu_view.dart';
import 'package:ess/Ess_App/src/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
    ));

    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              title: Constants.appTitle,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: NavService.onGenerateRoute,
              navigatorKey: NavService.key,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  useMaterial3: true,
                  colorScheme: ColorScheme(brightness: Brightness.light, primary: AppColors.primary, onPrimary: AppColors.white, secondary: AppColors.secondary, onSecondary: AppColors.white, error: Colors.red, onError: AppColors.white, background: AppColors.white, onBackground: AppColors.white, surface: AppColors.white, onSurface: AppColors.primary),
              ),
              home: SplashView(),
              builder: (context, child) {
                return snapshot.data == ConnectivityResult.none
                    ? NoInternet()
                    : Navigator(
                  onGenerateRoute: (setting) => MaterialPageRoute(
                      builder: (_) => Scaffold(
                        drawer: MenuView(),
                        drawerEnableOpenDragGesture: false,
                        body: Stack(
                          children: [child!],
                        ),
                      )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.screenSize().width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesConnectionLost,
              width: context.screenSize().width * 0.8,
              height: context.screenSize().width * 0.8,
            ),
            VerticalSpacing(15),
            Text(
              "No Internet Found",
              style: TextStyling.bold20.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
