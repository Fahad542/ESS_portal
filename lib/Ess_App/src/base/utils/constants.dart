import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static String get appTitle => "Ess DashBoard";

  static void customErrorSnack(BuildContext context, String msg,
      {String? title}) {
    CherryToast.error(
            title: Text(title ?? "Error"), description: Text(msg.toString()))
        .show(context);
  }

  static void customSuccessSnack(BuildContext context, String msg,
      {String? title}) {
    CherryToast.success(
            title: Text(title ?? "Congrats"), description: Text(msg.toString()))
        .show(context);
  }

  static void customWarningSnack(BuildContext context, String msg,
      {String? title}) {
    CherryToast.warning(
            title: Text(title ?? "Warning"), description: Text(msg.toString()))
        .show(context);
  }
}
