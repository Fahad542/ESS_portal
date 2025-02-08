import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class biometricViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel {
  bool isSignInButtonEnable = false;
  bool isShowPassword = false;
  bool isdevicesupport = false;
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? availableBiometrics;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> checkBiometric() async {
    try {
      isdevicesupport = await auth.canCheckBiometrics;
      print("Biometric supported: $isdevicesupport");
    } on PlatformException catch (e) {
      print("PlatformException: $e");
      isdevicesupport = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print("Supported biometrics: $availableBiometrics");
    } on PlatformException catch (e) {
      print("PlatformException: $e");
    }
    notifyListeners(); // Notify listeners if the biometrics list changes
  }

  Future<void> authenticateWithBiometrics(BuildContext context) async {
    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Authenticate with fingerprint or Face ID',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        await onLogIn(context); // Call onLogIn after successful authentication
      } else {
        // Authentication failed
        Constants.customErrorSnack(context, "Authentication was unsuccessful. Please try again.");
      }
    } on PlatformException catch (e) {
      // Detailed error logging
      print("PlatformException during authentication: ${e.message}");
      Constants.customErrorSnack(context, "Biometric authentication failed: ${e.message}");
    } catch (e) {
      // General error catch
      print("Unexpected error during authentication: $e");
      Constants.customErrorSnack(context, "An unexpected error occurred: $e");
    }
  }


  Future<void> onLogIn(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.login(
      context,
      email.text.trim(),
      password.text.trim(),
    ));

    newsResponse.when(
      success: (data) async {
        if (data.email != null) {
          authService.user = data;
          await subscribeToken(context);
          NavService.dashboard();
          Constants.customSuccessSnack(context, "Welcome Back ${data.userName}");
        } else {
          Constants.customErrorSnack(context, data.loginMsg.toString());
        }
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
  }

  Future<void> subscribeToken(BuildContext context) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("Token: $token");
      var newsResponse = await runBusyFuture(apiService.tokenSubscribe(context, token ?? ""));
      newsResponse.when(
        success: (data) {
          print("Subscription successful: $data");
        },
        failure: (error) {
          Constants.customErrorSnack(context, error.toString());
        },
      );
    } catch (e) {
      print("Error subscribing token: $e");
      Constants.customErrorSnack(context, "Token subscription failed");
    }
  }

  void checkButtonValidate(BuildContext context) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)) {
      if (password.text.length > 3) {
        isSignInButtonEnable = true;
      } else {
        isSignInButtonEnable = false;
      }
    } else {
      isSignInButtonEnable = false;
    }
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
