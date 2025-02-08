// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ess/Ess_App/src/models/api_response_models/capex_forms.dart' as _i18;
import 'package:ess/Ess_App/src/views/capex/apply_capex/apply_capex_view.dart' as _i11;
import 'package:ess/Ess_App/src/views/capex/capex_detail/capex_detail_view.dart'
    as _i12;
import 'package:ess/Ess_App/src/views/capex/capex_forms/capex_forms_view.dart' as _i13;
import 'package:ess/Ess_App/src/views/dashboard/dashboard_view.dart' as _i5;
import 'package:ess/Ess_App/src/views/fnf/apply_fnf/apply_fnf_view.dart' as _i14;
import 'package:ess/Ess_App/src/views/leaves_and_visits/apply_leave/apply_leave_view.dart'
    as _i9;
import 'package:ess/Ess_App/src/views/leaves_and_visits/apply_visit/apply_visit_view.dart'
    as _i10;
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_leave_aplications/your_leave_aplications_view.dart'
    as _i7;
import 'package:ess/Ess_App/src/views/leaves_and_visits/your_visits/your_visits_view.dart'
    as _i8;
import 'package:ess/Ess_App/src/views/login/login_view.dart' as _i3;
import 'package:ess/App_menu.dart' as _i40;
import 'package:ess/Ess_App/src/views/notification/notification_view.dart' as _i4;
import 'package:ess/Ess_App/src/views/reservation/all_reservations/all_reservations_view.dart'
    as _i16;
import 'package:ess/Ess_App/src/views/your_attandence/pending_approval.dart'
as _i17;
import 'package:ess/Ess_App/src/views/leaves_and_visits/pending_visit_approval/vist_approval_view.dart'
as _i18;
import 'package:ess/Ess_App/src/views/reservation/reserve_board_room/reserve_board_room_view.dart'
    as _i15;
import 'package:ess/Ess_App/src/views/splash/splash_view.dart' as _i2;
import 'package:ess/Ess_App/src/views/your_attandence/your_attandence_view.dart' as _i6;
import 'package:flutter/cupertino.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i19;
import 'package:ess/Ess_App/src/views/Advance/final_advance_approval_view.dart' as _i20;
import 'package:ess/Ess_App/src/views/Loan/loan_view.dart' as _i21;
import 'package:ess/Ess_App/src/views/Loan/See_all_loan/see_all_loan_view.dart' as _i22;
import 'package:ess/Ess_App/src/views/Whistle_blowing/whistle_blowing_view.dart' as _i23;
import 'package:ess/Ess_App/src/views/Advance/request_advance_view.dart' as _i24;
import 'package:ess/Ess_App/src/views/Resignation_form/resignation_view.dart' as _i25;
import 'package:ess/Ess_App/src/views/Resignation_form/line_manager_approval/line_manager_approval.dart' as _i26;
import 'package:ess/Ess_App/src/views/Loan/Pending_guarantees/pending_guarantees_view.dart' as _i27;
import 'package:ess/Ess_App/src/views/Loan/Loan_history_for_hod/loan_history_view.dart' as _i28;
import 'package:ess/Ess_App/src/views/Profile_screen/profile_screen.dart' as _i29;
import 'package:ess/Ess_App/src/views/Loan/Pending_hod_Approval/pending_hod_approval_view.dart' as _i30;
import 'package:ess/Ess_App/src/views/Loan/Director_loan_approval/director_loan_approval.dart' as _i31;
import 'package:ess/Ess_App/src/views/Smart_goals/My_smart_goals/My_smart_goals_view.dart' as _i32;
import 'package:ess/Ess_App/src/views/Smart_goals/Edit_smart_goal/Edit_smart_goal_view.dart' as _i33;
import 'package:ess/Ess_App/src/views/Smart_goals/Add_training/Add_training_view.dart' as _i34;
import 'package:ess/Ess_App/src/views/Smart_goals/Add_training/My_training/My_training_view.dart' as _i35;
import 'package:ess/Ess_App/src/views/Members/Member_list/Member_list_view.dart' as _i36;
import 'package:ess/Ess_App/src/views/Copex/Capex_form.dart' as _i37;
import 'package:ess/Ess_App/src/views/Copex/Generate_capex/Generate_capex_view.dart' as _i38;
import 'package:ess/Ess_App/src/views/Profile_screen/Change_thumb_recognition.dart' as _i39;
import 'package:ess/360_survey_App/Screens/Login/Login_screen_view.dart' as _i41;
import 'package:ess/360_survey_App/Screens/Feedback/Feedback_view.dart' as _i42;
import 'package:ess/360_survey_App/Screens/Check_pool/check_poll_view.dart' as _i43;
import 'package:ess/360_survey_App/Screens/Dashboard/Dashboard_view.dart' as _i44;
import 'package:ess/Ess_App/src/views/QMS/add_temperature.dart' as _i45;
import 'package:ess/Ess_App/src/views/QMS/create_sheet.dart' as _i46;
import 'package:ess/Ess_App/src/views/QMS/tempurature_list_view.dart' as _i47;
import 'package:ess/Ess_App/src/views/QMS/View_sheets_view.dart' as _i48;
import 'package:ess/Ess_App/src/views/QMS/Store_incharge_approval_view.dart' as _i49;
import 'package:ess/Ess_App/src/views/QMS/Pharmacist_approval.dart' as _i50;
import '../models/api_response_models/warehouse_list_model.dart';
class Routes {
  static const splashView = '/';

  static const tempform = '/add-temperature';
  static const createsheet = '/create_sheet';
  static const tempuraturelistviewv = '/tempurature-list-view';
  static const store_encharge_approval = '/Store_incharge_approval_view';
  static const viewsheet = '/View_sheets_view';
  static const pharmacist_approval = '/Pharmacist-approval';
  static const loginView = '/login-view';
  static const loginsurvey='/Login-screen-view';
  // static const loginsurvey = '/login-view';
  static const AppMenu = '/App-menu';

  static const notificationView = '/notification-view';

  static const dashboardView = '/dashboard-view';

  static const yourAttendanceView = '/your-attendance-view';

  static const leaveApplicationsView = '/leave-applications-view';

  static const visitsView = '/visits-view';

  static const applyLeaveView = '/apply-leave-view';

  static const applyVisitView = '/apply-visit-view';

  static const applyCapexView = '/apply-capex-view';

  static const capexDetailView = '/capex-detail-view';

  static const capexFormsView = '/capex-forms-view';
  static const capexgenerate = '/Generate-capex-view';
  static const applyFnfView = '/apply-fnf-view';
  static const training = '/Add_training_view.dart';
  static const reserveBoardRoomView = '/reserve-board-room-view';

  static const allReservationsView = '/all-reservations-view';
  static const pendingapproval = '/pending_approval';
  static const pendingvisitapproval = '/visit_approval_view';
  static const finaladvance=   '/final-advance-approval-view';
  static const requestadvance=   '/request_advance_view';
  static const loan=   '/loan_view.dart';
  static const allloan=   '/see_all_loan_view.dart';
  static const loan_history=   '/loan_history_view.dart';
  static const pending_guarantee=   '/pending_guarantees_view.dart';
  static const Whistle=   '/whistle_blowing_view.dart';
  static const my_smart_goal=   '/My_smart_goals_view.dart';
  static const training_view=   '/My_training_view.dart';
  static const edit_smart_goal=   '/Edit_smart_goal_view.dart';
  static const capex_form=   '/Capex_form.dart';
  static const resignation=   '/resignation_view.dart';
  static const profile=   '/profile_screen.dart';
  static const thumb=   '/Change_thumb_recognition.dart';
  static const member=   '/Member_list_view.dart';
  static const pending_hod_approval=   '/pending_hod_approval_view';
  static const direcctor_approvals= '/director_loan_approval';
  static const line_manager_approval= '/line_manager_approval.dart';
  static const Feedback_view= '/Feedback-view';
  static const survey_dashboard= '/Dashboard-view';
  static const check_poll_view= '/check-poll-view';
  static const all = <String>
  {
    pharmacist_approval,
    store_encharge_approval,
    viewsheet,
    tempuraturelistviewv,
    createsheet,
    tempform,
    Feedback_view,
    survey_dashboard,
    check_poll_view,
    splashView,
    loginView,
    loginsurvey,
    AppMenu,
    notificationView,
    dashboardView,
    yourAttendanceView,
    leaveApplicationsView,
    visitsView,
    applyLeaveView,
    applyVisitView,
    applyCapexView,
    capexDetailView,
    capexFormsView,
    applyFnfView,
    reserveBoardRoomView,
    allReservationsView,
    pendingapproval,
    pendingvisitapproval,
    finaladvance,
    loan,
    Whistle,
    resignation,
    requestadvance,
    line_manager_approval,
    pending_guarantee,
    loan_history,
    profile,
    my_smart_goal,
    pending_hod_approval,
    direcctor_approvals,
    edit_smart_goal,
    training,
    training_view,
    member,
    capex_form,
    capexgenerate,
    thumb
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.loginsurvey,
      page: _i41.Login_servey_app,
    ),
    _i1.RouteDef(
      Routes.Feedback_view,
      page: _i42.Feedbacks,
    ),
    _i1.RouteDef(
      Routes.check_poll_view,
      page: _i43.check_poll,
    ),
    _i1.RouteDef(
      Routes.survey_dashboard,
      page: _i44.DashboardScreen,
    ),
    _i1.RouteDef(
      Routes.AppMenu,
      page: _i40.AppMenu,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i4.NotificationView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i5.DashboardView,
    ),
    _i1.RouteDef(
      Routes.yourAttendanceView,
      page: _i6.YourAttendanceView,
    ),
    _i1.RouteDef(
      Routes.leaveApplicationsView,
      page: _i7.LeaveApplicationsView,
    ),
    _i1.RouteDef(
      Routes.visitsView,
      page: _i8.VisitsView,
    ),
    _i1.RouteDef(
      Routes.applyLeaveView,
      page: _i9.ApplyLeaveView,
    ),
    _i1.RouteDef(
      Routes.applyVisitView,
      page: _i10.ApplyVisitView,
    ),
    _i1.RouteDef(
      Routes.applyCapexView,
      page: _i11.ApplyCapexView,
    ),
    _i1.RouteDef(
      Routes.capexDetailView,
      page: _i12.CapexDetailView,
    ),
    _i1.RouteDef(
      Routes.capexFormsView,
      page: _i13.CapexFormsView,
    ),
    _i1.RouteDef(
      Routes.applyFnfView,
      page: _i14.ApplyFnfView,
    ),
    _i1.RouteDef(
      Routes.reserveBoardRoomView,
      page: _i15.ReserveBoardRoomView,
    ),
    _i1.RouteDef(
      Routes.allReservationsView,
      page: _i16.AllReservationsView,
    ),
    _i1.RouteDef(
      Routes.pendingapproval,
      page: _i17.Pendingapproval
    ),
    _i1.RouteDef(
        Routes.pendingvisitapproval,
        page: _i18.Pendingvisitapproval,
    ),
    _i1.RouteDef(
      Routes.finaladvance,
      page: _i20.final_advance
  ),
    _i1.RouteDef(
        Routes.loan,
        page: _i21.Loan
    ),
    _i1.RouteDef(
        Routes.allloan,
        page: _i22.Allloan
    ),
    _i1.RouteDef(
        Routes.Whistle,
        page: _i23.WhistleBlowingview
    ),
    _i1.RouteDef(
        Routes.requestadvance,
        page: _i24.requestadvance
    ),
    _i1.RouteDef(
        Routes.resignation,
        page: _i25.resignation_form,
    ),
    _i1.RouteDef(
      Routes.line_manager_approval,
      page: _i26.LineManager,
    ),
    _i1.RouteDef(
      Routes.pending_guarantee,
      page: _i27.Pending_guarantees,
    ),
    _i1.RouteDef(
      Routes.loan_history,
      page: _i28.Loan_history,
    ),
    _i1.RouteDef(
      Routes.profile,
      page: _i29.profile_screen,
    ),

    _i1.RouteDef(
      Routes.pending_hod_approval,
      page: _i30.Pending_hod_approval,
    ),
    _i1.RouteDef(
      Routes.direcctor_approvals,
      page: _i31.director_loan_approval,
    )
    ,
    _i1.RouteDef(
      Routes.my_smart_goal,
      page: _i32.Mysmartgoals,
    ),
    _i1.RouteDef(
      Routes.edit_smart_goal,
      page: _i33.Editsmartgoals,
    ),
    _i1.RouteDef(
      Routes.training,
      page: _i34.Add_trainig_view,
    ),
    _i1.RouteDef(
      Routes.training_view,
      page: _i35.My_trainig_view,
    ),
    _i1.RouteDef(
      Routes.member,
      page: _i36.MemberList,
    ),
    _i1.RouteDef(
      Routes.capex_form,
      page: _i37.ApplyCapexform,
    ),
    _i1.RouteDef(
      Routes.capexgenerate,
      page: _i38.GenerateCapex,
    ),
    _i1.RouteDef(
      Routes.thumb,
      page: _i39.thumb_recogition,
    ),
    _i1.RouteDef(
      Routes.tempform,
      page: _i45.TemperatureHumidityForm,
    ),

    _i1.RouteDef(
      Routes.createsheet,
      page: _i46.Create_new_sheet
    ),

    _i1.RouteDef(
        Routes.tempuraturelistviewv,
        page: _i47.tempurature_list_view
    ),

    _i1.RouteDef(
        Routes.viewsheet,
        page: _i48.view_sheet
    ),
    _i1.RouteDef(
        Routes.store_encharge_approval,
        page: _i49.Store_incharge_approval_view
    ),
    _i1.RouteDef(
        Routes.pharmacist_approval,
        page: _i50.pharmacist_approval_view
    ),





  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.arguments;
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(msg:args as String?,),
        settings: data,
      );
    },
    _i4.NotificationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i4.NotificationView(),
        settings: data,
      );
    },
    _i5.DashboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i5.DashboardView(),
        settings: data,
      );
    },
    _i6.YourAttendanceView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i6.YourAttendanceView(),
        settings: data,
      );
    },
    _i7.LeaveApplicationsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i7.LeaveApplicationsView(),
        settings: data,
      );
    },
    _i8.VisitsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i8.VisitsView(),
        settings: data,
      );
    },
    _i9.ApplyLeaveView: (data) {
      final args = data.getArgs<ApplyLeaveViewArguments>(
        orElse: () => const ApplyLeaveViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.ApplyLeaveView(key: args.key, date: args.date),
        settings: data,
      );
    },
    _i10.ApplyVisitView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i10.ApplyVisitView(),
        settings: data,
      );
    },
    _i11.ApplyCapexView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i11.ApplyCapexView(),
        settings: data,
      );
    },
    _i12.CapexDetailView: (data) {
      final args = data.getArgs<CapexDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i12.CapexDetailView(key: args.key, data: args.data),
        settings: data,
      );
    },
    _i13.CapexFormsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i13.CapexFormsView(),
        settings: data,
      );
    },
    _i14.ApplyFnfView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i14.ApplyFnfView(),
        settings: data,
      );
    },
    _i15.ReserveBoardRoomView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i15.ReserveBoardRoomView(),
        settings: data,
      );
    },
    _i16.AllReservationsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i16.AllReservationsView(),
        settings: data,
      );
    },
    _i17.Pendingapproval: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i17.Pendingapproval(),
        settings: data,
      );
    },
    _i18.Pendingvisitapproval: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i18.Pendingvisitapproval(),
        settings: data,
      );
    },
    _i20.final_advance: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i20.final_advance(),
        settings: data,
      );
    },
    _i21.Loan: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i21.Loan(),
        settings: data,
      );
    },
    _i22.Allloan: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i22.Allloan(),
        settings: data,
      );
    },
    _i23.WhistleBlowingview: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i23.WhistleBlowingview(),
        settings: data,
      );
    },
    _i24.requestadvance: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i24.requestadvance(),
        settings: data,
      );
    },
    _i25.resignation_form: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i25.resignation_form(),
        settings: data,
      );
    },
    _i26.LineManager: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i26.LineManager(),
        settings: data,
      );
    },
    _i27.Pending_guarantees: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i27.Pending_guarantees(),
        settings: data,
      );
    },
    _i28.Loan_history: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i28.Loan_history(),
        settings: data,
      );
    },
    _i29.profile_screen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i29.profile_screen(),
        settings: data,
      );
    },
    _i30.Pending_hod_approval: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i30.Pending_hod_approval(),
        settings: data,
      );
    },
    _i31.director_loan_approval: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i31.director_loan_approval(),
        settings: data,
      );
    },
    _i32.Mysmartgoals: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i32.Mysmartgoals(),
        settings: data,
      );
    },
    _i33.Editsmartgoals: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i33.Editsmartgoals(),
        settings: data,
      );
    },
    _i34.Add_trainig_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i34.Add_trainig_view(),
        settings: data,
      );
    },
    _i35.My_trainig_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i35.My_trainig_view(),
        settings: data,
      );
    },
    _i36.MemberList: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i36.MemberList(),
        settings: data,
      );
    },
    _i37.ApplyCapexform: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i37.ApplyCapexform(),
        settings: data,
      );
    },
    _i37.ApplyCapexform: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i37.ApplyCapexform(),
        settings: data,
      );
    },
    _i38.GenerateCapex: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i38.GenerateCapex(),
        settings: data,
      );
    },
    _i39.thumb_recogition: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i39.thumb_recogition(),
        settings: data,
      );
    },
    _i40.AppMenu: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i40.AppMenu(),
        settings: data,
      );
    },
    _i41.Login_servey_app: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i41.Login_servey_app(),
        settings: data,
      );
    },
    _i42.Feedbacks: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i42.Feedbacks(),
        settings: data,
      );
    },
    _i43.check_poll: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i43.check_poll(),
        settings: data,
      );
    },
    _i44.DashboardScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i44.DashboardScreen(),
        settings: data,
      );
    },
    // _i45.TemperatureHumidityForm: (data) {
    //   Object? args = data.arguments;
    //   return MaterialPageRoute<dynamic>(
    //     builder: (context) => _i45.TemperatureHumidityForm(data: args as Warehouselist,),
    //     settings: data,
    //   );
    // },
    _i46.Create_new_sheet: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i46.Create_new_sheet(),
        settings: data,
      );
    },
    _i47.tempurature_list_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i47.tempurature_list_view(),
        settings: data,
      );
    },
    _i48.view_sheet: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i48.view_sheet(),
        settings: data,
      );
    },


    _i49.Store_incharge_approval_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i49.Store_incharge_approval_view(),
        settings: data,
      );
    },

    _i50.pharmacist_approval_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i50.pharmacist_approval_view(),
        settings: data,
      );
    },

  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ApplyLeaveViewArguments {
  const ApplyLeaveViewArguments({
    this.key,
    this.date,
  });

  final _i17.Key? key;

  final String? date;
}

class CapexDetailViewArguments {
  const CapexDetailViewArguments({
    this.key,
    required this.data,
  });

  final _i17.Key? key;

  final _i18.Datalist data;
}

extension NavigatorStateExtension on _i19.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToYourAttendanceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.yourAttendanceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLeaveApplicationsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.leaveApplicationsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVisitsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.visitsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplyLeaveView({
    _i17.Key? key,
    String? date,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.applyLeaveView,
        arguments: ApplyLeaveViewArguments(key: key, date: date),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplyVisitView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.applyVisitView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplyCapexView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.applyCapexView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCapexDetailView({
    _i17.Key? key,
    required _i18.Datalist data,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.capexDetailView,
        arguments: CapexDetailViewArguments(key: key, data: data),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCapexFormsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.capexFormsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplyFnfView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.applyFnfView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReserveBoardRoomView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.reserveBoardRoomView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllReservationsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allReservationsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithYourAttendanceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.yourAttendanceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLeaveApplicationsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.leaveApplicationsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVisitsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.visitsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplyLeaveView({
    _i17.Key? key,
    String? date,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.applyLeaveView,
        arguments: ApplyLeaveViewArguments(key: key, date: date),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplyVisitView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.applyVisitView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplyCapexView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.applyCapexView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCapexDetailView({
    _i17.Key? key,
    required _i18.Datalist data,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.capexDetailView,
        arguments: CapexDetailViewArguments(key: key, data: data),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCapexFormsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.capexFormsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplyFnfView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.applyFnfView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithReserveBoardRoomView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.reserveBoardRoomView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllReservationsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allReservationsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
  Future<dynamic> replaceWithAllfinaladvance([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  ]) async {
    return replaceWith<dynamic>(Routes.finaladvance,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
