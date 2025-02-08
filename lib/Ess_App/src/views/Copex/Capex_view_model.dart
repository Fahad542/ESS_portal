import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/capex_form_data.dart';
import 'package:ess/Ess_App/src/models/api_response_models/branches.dart' as br;
import 'package:ess/Ess_App/src/models/api_response_models/capex_item.dart' as ct;
import 'package:ess/Ess_App/src/models/api_response_models/region.dart' as Rg;
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:stacked/stacked.dart';
import '../../configs/app_setup.locator.dart';
import '../../models/api_response_models/user.dart';
import '../../services/local/auth_service.dart';

class CapexViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {

  int indexcapex=0;
  List<String> capexForList = ["Select Capex Type","IT", "ADMIN"];
  String title='Select capex';
  String selectedcapexForList='';
  int capexForIndex = 0;
  List<int> selectedItemIndices = [];
  List<int> quantities = [];
  List<String> selectedCapex = [];
  TextEditingController employeeCode = TextEditingController();
  TextEditingController empName = TextEditingController();
  TextEditingController empPosition = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController qty = TextEditingController();

  AuthService _authService = locator<AuthService>();
  User? get
  currentUser => _authService.user;
  int selectedBranchIndex = 0;
  List<br.Datalist> branches = [];
  int newIndex =0;
  int selectedRegionIndex = 0;
  List<Rg.Datalist> regions = [];
  int selectedItemIndex = 0;
  List<ct.Datalist> items = [];
  String? selectedValue='select a value';
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
    newIndex=newIndex+1;
    selectedItemIndices.add(newIndex);
    print(selectedCapex);
    print(selectedCapex);
    print(selectedItemIndices);

     quantities.add(1);

    // Notify listeners to update the UI
    notifyListeners();
  }

  void removeDropdownItem(int index) {
    //print(newIndex);
    newIndex=index;
    print(selectedItemIndices);
    selectedItemIndices.removeAt(index);

    print(index);



    print(selectedItemIndices);

    // Check if quantities and selectedCapex are not null
    if (quantities != 0 && selectedCapex != null) {
      // Ensure index is within bounds for quantities and selectedCapex
      if (index >= 0 && index < quantities.length && index < selectedCapex.length) {
        // Only remove items if the conditions are met
        if (quantities.isNotEmpty && index < quantities.length && selectedCapex.isNotEmpty && index < selectedCapex.length) {
          quantities.removeAt(index);
          selectedCapex.removeAt(index);
        }
      }
    }
    notifyListeners();
  }
  void applycapex(BuildContext context) async {
    if(selectedCapex.length > 0)
    {
      List<Map<String, dynamic>> itemData = [];
    for (int i = 0; i < selectedCapex.length; i++) {
      itemData.add({
          "itemid":selectedCapex[i],
          "qty": quantities[i]
      }
      );
    }
      print(itemData);
      var newsResponse = await runBusyFuture(apiService.capex(context,itemData,selectedcapexForList));
      print("sadas: ${newsResponse['status']}");
      if(newsResponse['status']=='200')
        {
          selectedcapexForList='';
          items.clear();
          selectedItemIndices.clear();

          notifyListeners();
          Constants.customSuccessSnack(context, newsResponse['status_message']);
        }
      else
        {
          Constants.customSuccessSnack(context, newsResponse['status_message']);
        }

      // newsResponse?.then((dynamic data) async {
      //   print("data: ${newsResponse}");
      //   if(data['status']=="200")
      //     {
      //       Constants.customSuccessSnack(context, data['status_message']);
      //
      //     }
      //
      //   else {
      //     Constants.customSuccessSnack(context, data['status_message']);
      //   }
      // }, failure: (error) {
      //
      //   Constants.customErrorSnack(context, error.toString());
      //   print("object");
      // });

    }
    else {
      Constants.customErrorSnack(context, "Please Select the Capex First");
    }
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
