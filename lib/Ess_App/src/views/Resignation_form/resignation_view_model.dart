

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../base/utils/constants.dart';
import '../../models/api_response_models/branch.dart';
import '../../models/api_response_models/region.dart';
import '../../services/local/base/auth_view_model.dart';
import '../../services/remote/base/api_view_model.dart';
import 'dart:io';

class ResignationViewModel extends ReactiveViewModel with  AuthViewModel, ApiViewModel {


  List<String> capexForList = ["Self", "For Employee"];
  int capexForIndex = 0;
  FilePickerResult? result;
  var _imageFile;
  String imagepath = "";
  ImagePicker picker = ImagePicker();

  Future<void> getImageCamera() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png',],
      );

      if (result != null) {
        final pickedFile = result.files.first;

        if (pickedFile.extension == 'pdf') {
          imagepath = pickedFile.path!;
          notifyListeners();
        } else {

          final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            imagepath = pickedImage.path;
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }


  List<finalbranch> branchlist = [];
 List<Datalist> regions=[];
  DateTime bookDateFormat = DateTime.now();
  String? branchvalue;
  String? regionvalue;
  List<String> loan_applicants = ["Self","For Employee"];
  String? loanapplicants;
  TextEditingController fathernamecontroller = TextEditingController();
  TextEditingController cniccontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController jobcontroller = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController lastdaycontroller = TextEditingController();
  TextEditingController empName = TextEditingController();
  TextEditingController empPosition = TextEditingController();
  TextEditingController departmentcontroller = TextEditingController();
  TextEditingController empcodecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController startdatecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController lastdatecontroller = TextEditingController();
  TextEditingController noticeperiod = TextEditingController();



  TextEditingController qty = TextEditingController();



  init(BuildContext context) async {
    branchdata(context);
    getRegions(context);
  }

  clear(){
    fathernamecontroller.clear();
    cniccontroller.clear();
    namecontroller.clear();
    jobcontroller.clear();
    reasoncontroller.clear();
    lastdaycontroller.clear();
    empName.clear();
    empPosition.clear();
    departmentcontroller.clear();
    empcodecontroller.clear();
    mobilenumbercontroller.clear();
    startdatecontroller.clear();
    enddatecontroller.clear();
    noticeperiod.clear();
    branchvalue='';
    regionvalue="";
    imagepath='';

  }


  Future<void> branchdata(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.branchapi(context));
    newsResponse.when(
      success: (data) {
        // Append data to finalApprovalData
        branchlist=data.approvalItems;

      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      },
    );
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

  Future<void> applyresignation(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.applyresignation(empcodecontroller.text, namecontroller.text, loanapplicants.toString(), departmentcontroller.text, branchvalue.toString(), startdatecontroller.text, enddatecontroller.text, mobilenumbercontroller.text, fathernamecontroller.text, cniccontroller.text, jobcontroller.text, reasoncontroller.text, noticeperiod.text, lastdaycontroller.text, regionvalue.toString(),imagepath));
  newsResponse.when(
      success: (data) {
        newsResponse.when(
          success: (data) {
            if (data == "FNF Submitted Successfully") {
              clear();
              Constants.customSuccessSnack(
                  context, data);
              print(data);

            } else {
              Constants.customErrorSnack(
                  context, data);
              print(data);
            }
          },
          failure: (error) {
            Constants.customErrorSnack(context, error.toString());
            print(error.toString());
          },
        );
      },
      failure: (error) {
        Constants.customErrorSnack(context, error.toString());
        print(error.toString());
      },
    );
  }
}




