import 'package:ess/Ess_App/src/views/Members/Member_list/Member_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../base/utils/constants.dart';
import '../../../models/api_response_models/Member_model.dart';
import '../../../services/local/base/auth_view_model.dart';
import '../../../services/remote/base/api_view_model.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// Import other necessary packages and files such as AuthViewModel, ApiViewModel, Member, apiService, and Constants

class MemberViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {
  List<Member> reservationData = [];
  List<Member> filteredData = [];
  TextEditingController controller = TextEditingController();

  MemberViewModel() {
    controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  Future<void> init(BuildContext context) async {
    await fetchMemberList(context);
    notifyListeners();  // Notifying listeners after the member list is fetched
  }

  Future<void> fetchMemberList(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.memberlist(context));
    newsResponse.when(
      success: (data) async {
        if (data.members?.isNotEmpty ?? false) {
          reservationData = data.members!.reversed.toList();
          filteredData = reservationData;
        } else {
          Constants.customWarningSnack(context, "Members not found");
        }
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
  }

  void _onSearchChanged() {
    updatesearchquery(controller.text);
  }

  void updatesearchquery(String query) {
    if (query.isEmpty) {
      filteredData = reservationData;
    } else {
      filteredData = reservationData.where((member)
      {
        final lowerCaseQuery = query.toLowerCase();
        final memberNameMatches = member.memberName.toLowerCase().contains(lowerCaseQuery);
        final codeMatches = member.memberCode.toLowerCase().contains(lowerCaseQuery);
        return memberNameMatches || codeMatches;
      }).toList();
    }
    notifyListeners();
  }





  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
