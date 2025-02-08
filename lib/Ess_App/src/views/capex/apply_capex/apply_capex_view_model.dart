import 'dart:async';

import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/capex_form_data.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/leave_form_data.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/visit_form_data.dart';
import 'package:ess/Ess_App/src/models/api_response_models/branches.dart' as br;
import 'package:ess/Ess_App/src/models/api_response_models/capex_item.dart' as ct;
import 'package:ess/Ess_App/src/models/api_response_models/leave_applications.dart';
import 'package:ess/Ess_App/src/models/api_response_models/region.dart' as Rg;
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:stacked/stacked.dart';

class ApplyCapexViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {


  List<String> capexForList = ["Self", "For Employee"];
  int capexForIndex = 0;
  List<int> selectedItemIndices = [0];
  List<int> quantities = [0];
  TextEditingController employeeCode = TextEditingController();
  TextEditingController empName = TextEditingController();
  TextEditingController empPosition = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController qty = TextEditingController();

  int selectedBranchIndex = 0;
  List<br.Datalist> branches = [];
  int selectedRegionIndex = 0;
  List<Rg.Datalist> regions = [];
  int selectedItemIndex = 0;
  List<ct.Datalist> items = [];

  init(BuildContext context) async {
    setBusy(true);
    await getBranches(context);
    await getRegions(context);
    await getItems(context);
    employeeCode.text = currentUser?.userId.toString() ?? "000000";
    empName.text = currentUser?.userName.toString() ?? "";
    setBusy(false);
  }
  void addDropdownItem() {
    quantities.add(0);
    selectedItemIndices.add(0);
    notifyListeners();
  }

  // Method to remove a dropdown item
  void removeDropdownItem(int index) {
    selectedItemIndices.removeAt(index);
    quantities.removeAt(index);
    notifyListeners();  // Notify listeners to update UI
  }
  void incrementQuantity(int index) {
    if (index >= 0 && index < quantities.length) {
      quantities[index]++;
      notifyListeners();  // Notify listeners to update UI
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < quantities.length && quantities[index] > 1) {
      quantities[index]--;
      notifyListeners();  // Notify listeners to update UI
    }
  }
  clear()
  {
    employeeCode.text = currentUser?.userId.toString() ?? "000000";
    empName.text = currentUser?.userName.toString() ?? "";
    empPosition.clear();
    department.clear();
    qty.clear();
    capexForIndex = 0;
    selectedBranchIndex = 0;
    selectedRegionIndex = 0;
    selectedItemIndex = 0;
  }

  getBranches(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getBranches(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0) {
        branches = data.datalist ?? [];
      }
    }, failure: (error) {

      Constants.customErrorSnack(context, error.toString());
      print("object");
    });
  }
  getRegions(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getRegions(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0) {
        regions = data.datalist ?? [];
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
  getItems(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getCapexItems(context));
    newsResponse.when(success: (data) async {
      if ((data.datalist?.length ?? 0) > 0) {
        items = data.datalist ?? [];
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }


  apply(BuildContext context) async {
    if(m.Form.of(context).validate()) {
      await setCapexForm(context);
    }
  }

  setCapexForm(BuildContext context,) async {
    CapexFormData formData = CapexFormData(
      capexFor: capexForList[capexForIndex].toLowerCase(),
      empCode: employeeCode.text,
      empName: empName.text,
      empPosition: empPosition.text,
      empBranch: branches[selectedBranchIndex].branchName,
      region: regions[selectedRegionIndex].regionName,
      department: department.text,
      itemname: items[selectedItemIndex].itemName,
      qty: qty.text,
    );
    var newsResponse = await runBusyFuture(apiService.applyCapex(context,formData));
    newsResponse.when(success: (data) async {
      if (data == "Request Successfully Submitted") {
        clear();
        Constants.customSuccessSnack(context, "Your Application Submitted Successfully");
        NavService.capexForms();
      } else {
        Constants.customErrorSnack(context, "Your Application Not Submit, Try Again");
      }
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
    });
  }
}
