import 'package:ess/Ess_App/src/configs/app_setup.locator.dart';
import 'package:ess/Ess_App/src/configs/app_setup.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../views/your_attandence/pending_approval.dart';
import '../../views/your_attandence/pending_approval.dart';
import '../../views/your_attandence/pending_approval.dart';
import '../../views/your_attandence/pending_approval.dart';

class NavService {
  static NavigationService? _navigationService = locator<NavigationService>();

  // key
  static GlobalKey<NavigatorState>? get key => StackedService.navigatorKey;

  // key for nested navigator to be used in SplashView
  static final _splashViewNavigatorId = 0;

  static GlobalKey<NavigatorState>? get nestedNavKey =>
      StackedService.nestedNavigationKey(_splashViewNavigatorId);

  // on generate route
  static Route<dynamic>? Function(RouteSettings) get onGenerateRoute =>
      StackedRouter().onGenerateRoute;

  static Future<dynamic>? splash({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.splashView, arguments: arguments);

  static Future<dynamic>? login({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.loginView, arguments: arguments);
  static Future<dynamic>? loginsurvey({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.loginsurvey, arguments: arguments);
  static Future<dynamic>? survey_feeback({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.Feedback_view, arguments: arguments);
  static Future<dynamic>? survey_poll({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.check_poll_view, arguments: arguments);
  static Future<dynamic>? survey_dashboard({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.survey_dashboard, arguments: arguments);
  static Future<dynamic>? appmenu({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.AppMenu, arguments: arguments);

  static Future<dynamic>? notification({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.notificationView, arguments: arguments);

  static Future<dynamic>? dashboard({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.dashboardView, arguments: arguments);

  static Future<dynamic>? yourAttendance({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.yourAttendanceView, arguments: arguments);

  static Future<dynamic>? leaveApplications({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.leaveApplicationsView, arguments: arguments);

  static Future<dynamic>? visits({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.visitsView, arguments: arguments);

  static Future<dynamic>? applyLeave({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.applyLeaveView, arguments: arguments);

  static Future<dynamic>? applyVisit({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.applyVisitView, arguments: arguments);
  static Future<dynamic>? temperatureform({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.tempform, arguments: arguments);
  static Future<dynamic>? createsheet({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.createsheet, arguments: arguments);
  static Future<dynamic>? tempurature_list_view({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.tempuraturelistviewv, arguments: arguments);
  static Future<dynamic>? store_encharge({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.store_encharge_approval, arguments: arguments);
  static Future<dynamic>? view_sheet({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.viewsheet, arguments: arguments);
  static Future<dynamic>? pharmacist_approval({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.pharmacist_approval, arguments: arguments);

  static Future<dynamic>? applyCapex({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.applyCapexView, arguments: arguments);

  static Future<dynamic>? capexForms({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.capexFormsView, arguments: arguments);
  static Future<dynamic>? Generatecapex({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.capexgenerate, arguments: arguments);

  static Future<dynamic>? capexDetail({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.capexDetailView, arguments: arguments);

  static Future<dynamic>? applyFnf({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.applyFnfView, arguments: arguments);

  static Future<dynamic>? allReservations({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.allReservationsView, arguments: arguments);

  static Future<dynamic>? reserveBoardRoom({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.reserveBoardRoomView, arguments: arguments);
  static Future<dynamic>? Pendingapproval({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.pendingapproval, arguments: arguments);
  static Future<dynamic>? Pendingvisitapproval({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.pendingvisitapproval, arguments: arguments);
  static Future<dynamic>? Final_advance({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.finaladvance, arguments: arguments);
  static Future<dynamic>? Request_advance({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.requestadvance, arguments: arguments);
  static Future<dynamic>? loan({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.loan, arguments: arguments);
  static Future<dynamic>? whistle({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.Whistle, arguments: arguments);
  static Future<dynamic>? smartgoal({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.my_smart_goal, arguments: arguments);
  static Future<dynamic>? training({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.training_view, arguments: arguments);
  static Future<dynamic>? training_view({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.training_view, arguments: arguments);
  static Future<dynamic>? editsmartgoal({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.edit_smart_goal, arguments: arguments);
  static Future<dynamic>? capexform({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.capex_form, arguments: arguments);
  static Future<dynamic>? addtraning({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.training, arguments: arguments);
  static Future<dynamic>? Resignation({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.resignation, arguments: arguments);
  static Future<dynamic>? profile({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.profile, arguments: arguments);
  static Future<dynamic>? thumb_recognition({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.thumb, arguments: arguments);
  static Future<dynamic>? member({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.member, arguments: arguments);
  static Future<dynamic>? pending_hod_approval({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.pending_hod_approval, arguments: arguments);
  static Future<dynamic>? director_approval({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.direcctor_approvals, arguments: arguments);
  static Future<dynamic>? line_manager({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.line_manager_approval, arguments: arguments);
  static Future<dynamic>? allloan({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.allloan, arguments: arguments);
  static Future<dynamic>? loan_history({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.loan_history, arguments: arguments);
  static Future<dynamic>? pending_guarantees({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.pending_guarantee, arguments: arguments);
}
