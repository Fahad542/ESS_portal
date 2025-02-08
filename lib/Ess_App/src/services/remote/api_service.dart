import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:ess/Ess_App/My_models/final_advancce_model.dart';
import 'package:ess/Ess_App/My_models/user_model.dart';
import 'package:ess/Ess_App/src/configs/app_setup.locator.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/capex_form_data.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/leave_form_data.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/reservation_form_data.dart';
import 'package:ess/Ess_App/src/models/api_form_data_models/visit_form_data.dart';
import 'package:ess/Ess_App/src/models/api_response_models/all_reservation.dart';
import 'package:ess/Ess_App/src/models/api_response_models/attendence.dart';
import 'package:ess/Ess_App/src/models/api_response_models/branches.dart';
import 'package:ess/Ess_App/src/models/api_response_models/capex_forms.dart';
import 'package:ess/Ess_App/src/models/api_response_models/capex_item.dart';
import 'package:ess/Ess_App/src/models/api_response_models/dashboard.dart';
import 'package:ess/Ess_App/src/models/api_response_models/guaranter.dart';
import 'package:ess/Ess_App/src/models/api_response_models/leave_applications.dart';
import 'package:ess/Ess_App/src/models/api_response_models/region.dart';
import 'package:ess/Ess_App/src/models/api_response_models/user.dart';
import 'package:ess/Ess_App/src/models/api_response_models/visits.dart';
import 'package:ess/Ess_App/src/services/local/auth_service.dart';
import 'package:ess/Ess_App/src/services/remote/api_client.dart';
import 'package:ess/Ess_App/src/services/remote/api_result.dart';
import 'package:ess/Ess_App/src/services/remote/network_exceptions.dart';
import 'package:flutter/cupertino.dart';

import '../../../My_models/pending_visit_approval.dart';
import '../../base/utils/constants.dart';
import '../../models/api_response_models/Batch_model.dart';
import '../../models/api_response_models/Capex_model.dart';
import '../../models/api_response_models/Hod_loan_approval.dart';
import '../../models/api_response_models/List_temperature_sheet.dart';
import '../../models/api_response_models/Loan_history_hod_model.dart';
import '../../models/api_response_models/Member_model.dart';
import '../../models/api_response_models/My_smart_goals.dart';
import '../../models/api_response_models/Training_model.dart';
import '../../models/api_response_models/advance_line_manager_approval.dart';
import '../../models/api_response_models/branch.dart';
import '../../models/api_response_models/branch.dart';
import '../../models/api_response_models/changepassword_model.dart';
import '../../models/api_response_models/director_model.dart';
import '../../models/api_response_models/fetch_loan_approval.dart';
import '../../models/api_response_models/loan_model.dart';
import '../../models/api_response_models/pending_guaranted.dart';
import '../../models/api_response_models/traning_model.dart';
import '../../models/api_response_models/warehouse_list_model.dart';
import '../../models/api_response_models/warehouse_model.dart';


class ApiService {
  ApiClient? _apiClient;
  var authService = locator<AuthService>();

  ApiService() {
    var dio = Dio();
    _apiClient = ApiClient(dio);
  }


  Future<ApiResult<User>> login(BuildContext context, String email,
      String password) async {
    try {
      var response = await _apiClient?.getReq(
        "/login_script.php?username=$email&password=$password",
      );

      var data = jsonDecode(response?.data);
      print(response.data);
      if (response?.statusCode != 200) {
        print("1");
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      print("2");
      print(data['data']);
      return ApiResult.success(data: User.fromJson(data['data']));
    }

    catch (e) {
      print("3");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<String>> tokenSubscribe(BuildContext context,
      String token) async {
    try {
      var response = await _apiClient?.getReq(
        "/insert_token.php?emp_code=${authService.user
            ?.userId}&fcm_token=$token",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['message']);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  //DashBoard
  Future<ApiResult<Dashboard>> dashboard(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/user_script.php?EMPCODE=${authService.user?.userId ?? 000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Dashboard.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<goalmodel>> mygoal(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/my_smart_goals.php?EMPCODE=${authService.user?.userId ?? 000000}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      print(data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: goalmodel.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<FormsModel>> training_view(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/my_training.php?emp_code=${authService.user?.userId ?? 000000}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: FormsModel.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<MembersList>> memberlist(BuildContext context) async {
    try {
      var response = await _apiClient?.getReqwithoutheader("/fetch_member.php");
      print(response?.statusCode);
      var data = jsonDecode(response?.data);
      print(data);

      if (response?.statusCode != 200) {
        return ApiResult.failure(
          error: NetworkExceptions.notFound(response?.message ?? "Incorrect"),
        );
      }

      return ApiResult.success(data: MembersList.fromJson(data));
    } catch (e) {
      print('Error: $e');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e)!,
      );
    }
  }

  Future<ApiResult<TrainingList>> traininglist(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/fetch_training_name.php",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: TrainingList.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Map<String, dynamic>>> check_employee_training(
      BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/check_employee_training.php?emp_code=${authService.user?.userId ??
              000000}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      var status = data['status'];
      var trainingCount = data['training_count'];
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(
          data: {'status': status, 'training_count': trainingCount,});
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<Map<String, dynamic>>> fetch_employee_goal_weightage(
      BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/fetch_employee_goal_weightage.php?emp_code=${authService.user
              ?.userId ?? 000000}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      var status = data['status'];
      var totalWeightage = data['totalWeightage'];
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(
          data: {'status': status, 'totalWeightage': totalWeightage,});
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Map<String, dynamic>>> add_goal(BuildContext context,
      String goalname, String goaldetail, String measures, String weightage,
      String batchid) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/add_goals.php?emp_code=${authService.user?.userId ??
              000000}&goal_name=${goalname}&goal_detail=${goaldetail}&measures=${measures}&weightage=${weightage}&batch_id=${batchid}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      var status = data['status'];
      var totalWeightage = data['status_message'];
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(
          data: {'status': status, 'status_message': totalWeightage,});
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Batch>> fetchbatchlist(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/fetch_batch_list.php",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      var datalist = data['Datalist'] as List<dynamic>;
      var formattedlist = datalist.map((e) => e as Map<String, dynamic>)
          .toList();
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Batch.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<Map<String, dynamic>>> add_traning(BuildContext context,
      String training1, String training2) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/add_training.php?emp_code=${authService.user?.userId ??
              000000}&training_1=${training1}&training_2=${training2}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      var status = data['status'];
      var status_message = data['status_message'];

      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(
          data: {'status': status, 'status_message': status_message,});
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  //Attendence
  Future<ApiResult<Attendance>> attendance(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_my_attendance.php?EMPCODE=${authService.user?.userId ??
            000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Attendance.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> markattendancne(BuildContext context, String lat,
      String long, String time) async {
    try {
      var response = await _apiClient?.getReq(
        "/mark_attendance.php?code=${authService.user?.userId ??
            000000}&lat=${lat}&lon=${long}&time=${time}",
      );
      print(response);
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data as Map<String, dynamic>);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> getcordinantes() async {
    try {
      var response = await _apiClient?.getReq(
        "/getOfficeCordinates.php?code=${authService.user?.userId ?? 000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['data'] as Map<String, dynamic>);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Usermodel>> approval(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_leave_approval.php?EMPCODE=${authService.user?.userId ??
            000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Usermodel.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<UsermodelVisit>> visitapproval(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_visit_approval.php?EMPCODE=${authService.user?.userId ??
            000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: UsermodelVisit.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<FormsData>> mycapex(BuildContext context) async {
    var headers = {
      'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
      'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
    };
    try {
      var response = await _apiClient?.getReq(
          "/fetch_mycapex_list.php?EMPCODE=${authService.user?.userId ??
              000000}",
          headers: headers
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: FormsData.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<Final_advance>> finaladvanceapproval(
      BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_advance_final_approval.php",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        print("1");
        return ApiResult.failure(

            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      print("2");
      return ApiResult.success(data: Final_advance.fromJson(data));
    } catch (e) {
      print("3");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<LoanType>> loanapproval(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/fetch_loan_type.php",
        headers: headers,
      );

      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: LoanType.fromJson(data));
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<fecthloan>> fetchloanapi(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/fetch_my_loan.php?EMPCODE=${authService.user?.userId ?? 000000}",
        headers: headers,
      );

      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: fecthloan.fromJson(data));
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<advancelinemanagver>> line_manager_approval_api(
      BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/advance_line_manager_approval.php?emp_code=${authService.user
            ?.userId ?? 000000}",
        headers: headers,
      );

      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: advancelinemanagver.fromJson(data));
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<fecthloan>> fetchloan(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_my_loan.php?EMPCODE=${authService.user?.userId ?? 000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: fecthloan.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<String>> applyloan(BuildContext context,
      String applicant_type, String loan_type,
      String emp_name, String emp_position, String emp_department,
      String branch_name, String pre_code
      , String emp_code, String mobile_number, String date_of_joining,
      String cnic_no, String loan_amount,
      String amount_in_word, String loan_purpose, String repay_loan_month,
      String repay_monthly_amount,
      String guarantor1, String guarantor2, var filePath) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=qonpm0sr92j93pkkqhju4713v2'
      };
      // var headers = {
      //   'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
      //   'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      // };
      // var response = await _apiClient?.getReq(
      //   "/apply_loan.php?membercode=${authService.user?.userId ?? 000000}&applicant_type=${applicant_type}&loan_type=${loan_type}"
      //       "&emp_name=${emp_name}&emp_position=${emp_position}&emp_department=${emp_department}&branch_name=${branch_name}&pre_code=${pre_code}&emp_code=${emp_code}&"
      //       "mobile_number=${mobile_number}&date_of_joining=${date_of_joining}&cnic_no=${cnic_no}&"
      //       "loan_amount=${loan_amount}&amount_in_word=${amount_in_word}&"
      //       "loan_purpose=${loan_purpose}&repay_loan_month=${repay_loan_month}&"
      //       "repay_monthly_amount=${repay_monthly_amount}&guarantor1=${guarantor1}&guarantor2=${guarantor2}",
      //   headers: headers,
      // );

      var request = http.MultipartRequest('POST', Uri.parse(
          'https://premierspulse.com/ess/scripts/apply_loan.php?membercode=${authService
              .user?.userId ??
              000000}&applicant_type=${applicant_type}&loan_type=${loan_type}&emp_name=${emp_name}&emp_position=${emp_position}&emp_department=${emp_department}&branch_name=${branch_name}&pre_code=${pre_code}&emp_code=${emp_code}&mobile_number=${mobile_number}&date_of_joining=${date_of_joining}&cnic_no=${cnic_no}&loan_amount=${loan_amount}&amount_in_word=${amount_in_word}&loan_purpose=${loan_purpose}&repay_loan_month=${repay_loan_month}&repay_monthly_amount=${repay_monthly_amount}&guarantor1=${guarantor1}&guarantor2=${guarantor2}'));
      print(
          'https://premierspulse.com/ess/scripts/apply_loan.php?membercode=${authService
              .user?.userId ??
              000000}&applicant_type=${applicant_type}&loan_type=${loan_type}&emp_name=${emp_name}&emp_position=${emp_position}&emp_department=${emp_department}&branch_name=${branch_name}&pre_code=${pre_code}&emp_code=${emp_code}&mobile_number=${mobile_number}&date_of_joining=${date_of_joining}&cnic_no=${cnic_no}&loan_amount=${loan_amount}&amount_in_word=${amount_in_word}&loan_purpose=${loan_purpose}&repay_loan_month=${repay_loan_month}&repay_monthly_amount=${repay_monthly_amount}&guarantor1=${guarantor1}&guarantor2=${guarantor2}');
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll(headers);
      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      http.Client().close();
      print(response);
      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.body}");


      var data = jsonDecode(response.body!);
      if (response.statusCode != 200) {
        String responseStatus = data["status"].toString();
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(
                "Incorrect Status: $responseStatus")
        );
      }
      return ApiResult.success(data: data['status_message']);
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<String>> linemanagerapp(BuildContext context, String id,
      String status) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/approved_linemanager_advance.php?case_id=${id}&status=${status}",
        headers: headers,
      );
      print(response);

      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      print("Response data: ${response.data}");

      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['status_message']);
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<String>> applywhistle(BuildContext context, String title,
      String detail,) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/apply_whistle.php?emp_code=${authService.user?.userId ??
            000000}&whistle_title=${title}&whistle_detail=${detail}",

        headers: headers,
      );
      print(response);
      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['status_message']);
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<String>> applyrequestadvancec(BuildContext context,
      String amount, String reason) async {
    try {
      // Check if brcode is null or zero
      if (authService.user?.brcode == null || authService.user?.brcode == "0") {
        print("brcode is null or zero, API not called");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("brcode is null or zero"));
      }

      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/apply_advance_form.php?emp_code=${authService.user?.userId ??
            "000000"}&brcode=${authService.user
            ?.brcode}&advance_amount=${amount}&advance_reason=${reason}",
        headers: headers,
      );

      print(response);
      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['status_message']);
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<PendingGuarantee>> pendingguaranter(
      BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "pending_guarantees.php?emp_code=${authService.user?.userId ?? 000000}",
        headers: headers,
      );

      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: PendingGuarantee.fromJson(data));
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<guaranter>> guaranterapi(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "fetch_guarantor.php?membercode=${authService.user?.userId ?? 000000}",
        headers: headers,
      );

      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: guaranter.fromJson(data));
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<branch>> branchapi(BuildContext context) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "fetch_branchname.php",
        headers: headers,
      );

      // Check if response is null
      if (response == null) {
        print("Empty response received");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Empty response received"));
      }

      // Print response data for debugging
      print("Response data branch: ${response.data}");

      // Check if response data is null
      if (response.data == null) {
        print("Response data is null");
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Response data is null"));
      }

      var data = jsonDecode(response.data!);
      if (response.statusCode != 200) {
        print("Request failed with status code: ${response.statusCode}");
        return ApiResult.failure(
            error: NetworkExceptions.notFound(response.message ?? "Incorrect"));
      }
      return ApiResult.success(data: branch.fromJson(data));
    } catch (e) {
      print("Error occurred: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> approvalstatus(String status, String id) async {
    try {
      var response = await _apiClient?.getReq(
        "https://premierspulse.com/ess/scripts/leave_approval.php?status=$status&id=$id",
      );

      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> loanapprovalstatus(String status,
      String id) async {
    try {
      var response = await _apiClient?.getReq(
        "https://premierspulse.com/ess/scripts/approved_linemanager_advance.php?status=$status&id=$id",
      );

      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> visitapprovalstatus(String status,
      String id) async {
    try {
      var response = await _apiClient?.getReq(
        "https://premierspulse.com/ess/scripts/visit_approval.php?visitid=$id&status=$status",
      );

      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


/////////////////////////////////////////
  Future<ApiResult<dynamic>> linemanagerapprovalstatus(String status,
      String id) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/approved_linemanager_advance.php?case_id=$id&status=$status",
          headers: headers
      );

      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(error: NetworkExceptions.notFound(
                "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<fecthhistory>> loan_history() async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var res = await _apiClient?.getReq(
          "/loan_history_for_hod.php?EMPCODE=${authService.user?.userId ??
              000000}",
          headers: headers
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.data);
        return ApiResult.success(data: fecthhistory.fromJson(data));
      }
      else {
        return ApiResult.failure(
            error: NetworkExceptions.notFound(res.message ?? "Incorrect"));
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<hodloanmodel>> loan_approval_hod() async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var res = await _apiClient?.getReq(
          "/hod_loan_approvals.php?EMPCODE=${authService.user?.userId ??
              000000}",
          headers: headers
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.data);
        return ApiResult.success(data: hodloanmodel.fromJson(data));
      }
      else {
        return ApiResult.failure(
            error: NetworkExceptions.notFound(res.message ?? "Incorrect"));
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<director>> director_loan_approval() async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var res = await _apiClient?.getReq(
          "/director_loan_approvals.php?EMPCODE=${authService.user?.userId ??
              000000}",
          headers: headers
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.data);
        return ApiResult.success(data: director.fromJson(data));
      }
      else {
        return ApiResult.failure(
            error: NetworkExceptions.notFound(res.message ?? "Incorrect"));
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> updateloan(String loanid, String newloanamont,
      String loanrepaytenure, String loaninstalment) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      final response = await _apiClient?.getReq(
          "/update_loan_detail.php?empname=${authService.user
              ?.userName}&loan_id=${loanid}&new_loan_amount=${newloanamont}&loan_repay_tenure=${loanrepaytenure}&loan_installment=${loaninstalment}",
          headers: headers
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        return ApiResult.success(data: data);
      }
      else {
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Incorrect Status: $response")
        );
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<dynamic>> updateloandirector(String loanid,
      String newloanamont, String loanrepaytenure, String loaninstalment,
      String from_company, String from_employee_pf) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      final response = await _apiClient?.getReq(
          "/update_dir_loan_detail.php?empname=${authService.user
              ?.userName}&loan_id=${loanid}&new_loan_amount=${newloanamont}&loan_repay_tenure=${loanrepaytenure}&loan_installment=${loaninstalment}&from_company=${from_company}&from_employee_pf=${from_employee_pf}",
          headers: headers
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        return ApiResult.success(data: data);
      }
      else {
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Incorrect Status: $response")
        );
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<dynamic>> updateloantype(String loanid,
      String newloantype) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      final response = await _apiClient?.getReq(
          "/update_loan_type.php?loan_id=${loanid}&new_loan_type=${newloantype}",
          headers: headers
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        return ApiResult.success(data: data);
      }
      else {
        return ApiResult.failure(
            error: NetworkExceptions.notFound("Incorrect Status: $response")
        );
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> finalapprovalstatus(String status, String id,
      String amount, String remarks) async {
    try {
      var response = await _apiClient?.getReq(
        "https://premierspulse.com/ess/scripts/adv_fin_approval.php?case_id=$id&final_amount=$amount&status=$status&remarks=$remarks",

        //print("https://premierspulse.com/ess/scripts/adv_fin_approval.php?case_id=$id&final_amount=$amount&status=$status&remarks=$remarks");
      );
      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<dynamic>> approved_pending_guarantor(String status,
      String loan_id, String gua) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/approved_pending_guarantor.php?loan_id=${loan_id}&status=${status}&guar_state=${gua}",

          //print("https://premierspulse.com/ess/scripts/adv_fin_approval.php?case_id=$id&final_amount=$amount&status=$status&remarks=$remarks");
          headers: headers
      );
      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> hod_loan_approved(String status, String loan_id,
      String comment) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
          "/hod_loan_approved.php?loan_id=${loan_id}&comment=${comment}&status=${status}",

          //print("https://premierspulse.com/ess/scripts/adv_fin_approval.php?case_id=$id&final_amount=$amount&status=$status&remarks=$remarks");
          headers: headers
      );
      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<dynamic>> director_loan_approved(String status,
      String loan_id, String comment) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=0qga4kkbhct0q1ejhl93b5oj8p'
      };
      var response = await _apiClient?.getReq(
        "/director_loan_approved.php?loan_id=${loan_id}&comment=${comment}&status=${status}&directorname=${authService
            .user?.userName}",

        //print("https://premierspulse.com/ess/scripts/adv_fin_approval.php?case_id=$id&final_amount=$amount&status=$status&remarks=$remarks");
        headers: headers,


      );
      if (response?.statusCode == 200) {
        var data = jsonDecode(response.data);

        if (data != null && data.containsKey("status")) {
          // Check if "status" is present in the JSON response
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            // Successful status code
            if (status == "approved") {
              print("Request is Approved");
            } else if (status == "rejected") {
              print("Request is Rejected");
            }

            // Return a successful result
            return ApiResult.success(data: data);
          } else {
            // Handle other status codes if needed
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        } else {
          // "status" key is missing in the JSON response
          return ApiResult.failure(
              error: NetworkExceptions.notFound(
                  "Status key is missing in JSON response")
          );
        }
      } else {
        // Return a failure result with an error message
        return ApiResult.failure(
          error: NetworkExceptions.notFound(
              response?.statusMessage ?? "Incorrect"),
        );
      }
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<String>> applyresignation(String empcode, String empname,
      String fnf_type, String emp_dept, String branch, String doj, String dor,
      String contact, String father_name, String cnic, String designation,
      String reason, String notice_period, String last_day, String region,
      var filePath) async {
    try {
      var headers = {
        'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
        'Cookie': 'PHPSESSID=qonpm0sr92j93pkkqhju4713v2'
      };
      var request = http.MultipartRequest('POST', Uri.parse(
          'https://premierspulse.com/ess/scripts/apply_fnf.php?login_emp_code=${authService
              .user?.userId ??
              000000}&fnf_type=${fnf_type}&emp_code=${empcode}&emp_name=${empname}&emp_dept=${emp_dept}&branch=${branch}&doj=${doj}&dor=${dor}&contact=${contact}&father_name=${father_name}&cnic=${cnic}&designation=${designation}&reason=${reason}&notice_period=${notice_period}&last_day=${last_day}&region=${region}'));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll(headers);
      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      http.Client().close();
      var data = jsonDecode(response.body);
      if (myRequest.statusCode == 200) {
        if (data != null && data.containsKey("status")) {
          String responseStatus = data["status"].toString();

          if (responseStatus == "200") {
            return ApiResult.success(data: data['status_message']);
          } else {
            return ApiResult.failure(
                error: NetworkExceptions.notFound(
                    "Incorrect Status: $responseStatus")
            );
          }
        }
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  // Future<ApiResult<String>> applyloanwithattachments(String empcode, String empname, String fnf_type, String emp_dept, String branch, String doj, String dor, String contact, String father_name, String cnic, String designation, String reason, String notice_period, String last_day, String region, var filePath) async {
  //   try {
  //     var headers = {
  //       'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
  //       'Cookie': 'PHPSESSID=qonpm0sr92j93pkkqhju4713v2'
  //     };
  //     var request = http.MultipartRequest('POST', Uri.parse('https://premierspulse.com/ess/scripts/apply_loan.php?membercode=${authService.user?.userId ?? 000000}&applicant_type=${}&loan_type=${}&emp_name=${authService.user?.userName}&emp_position=${authService.user?.member_designation}&emp_department=${authService.user.}&branch_name=Head Office&pre_code=999&emp_code=45765&mobile_number=03152916066&date_of_joining=2024-04-18&cnic_no=4210119615567&loan_amount=10000&amount_in_word=ten thousand only&loan_purpose=testing&repay_loan_month=5&repay_monthly_amount=2000&guarantor1=99945765&guarantor2=99945765'));
  //     request.files.add(await http.MultipartFile.fromPath('file', filePath));
  //     request.headers.addAll(headers);
  //     var myRequest = await request.send();
  //     var response = await http.Response.fromStream(myRequest);
  //     http.Client().close();
  //     var data=jsonDecode(response.body);
  //     if (myRequest.statusCode == 200) {
  //       if (data != null && data.containsKey("status")) {
  //         String responseStatus = data["status"].toString();
  //
  //         if (responseStatus == "200") {
  //           return ApiResult.success(data: data['status_message']);
  //         } else {
  //           return ApiResult.failure(
  //               error: NetworkExceptions.notFound(
  //                   "Incorrect Status: $responseStatus")
  //           );
  //         }}
  //       return jsonDecode(response.body);
  //     } else {
  //       return jsonDecode(response.body);
  //     }
  //   }
  //   catch(e){
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
  //
  //   }
  // }


// Assuming you've imported the necessary packages
//
//   Future<ApiResult<String>> applyresignation(String empCode, String empName, String fnfType, String empDept, String branch, String doj, String dor, String contact, String fatherName, String cnic, String designation, String reason, String noticePeriod, String lastDay, String region, var filePath) async {
//     try {
//       var headers = {
//         'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
//         'Cookie': 'PHPSESSID=52lj4cljskg6b9e97rgn55c6s4'
//       };
//
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://premierspulse.com/ess/scripts/apply_fnf.php'),
//       );
//
//       request.fields.addAll({
//         'login_emp_code': empCode,
//         'fnf_type': fnfType,
//         'emp_code': empCode,
//         'emp_name': empName,
//         'emp_dept': empDept,
//         'branch': branch,
//         'doj': doj,
//         'dor': dor,
//         'contact': contact,
//         'father_name': fatherName,
//         'cnic': cnic,
//         'designation': designation,
//         'reason': reason,
//         'notice_period': noticePeriod,
//         'last_day': lastDay,
//         'region': region,
//       });
//
//       var stream = http.ByteStream(filePath!.openRead());
//       stream.cast();
//       var length = await filePath.length();
//       var multipartFile = http.MultipartFile("file", stream, length,
//           filename: filePath.path.split('/').last);
//
//       request.files.add(multipartFile);
//       request.headers.addAll(headers);
//
//       var response = await http.Response.fromStream(await request.send());
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//
//         if (data != null && data.containsKey("status")) {
//           String responseStatus = data["status"].toString();
//
//           if (responseStatus == "200") {
//             return ApiResult.success(data: data['status_message']);
//           } else {
//             return ApiResult.failure(
//                 error: NetworkExceptions.notFound("Incorrect Status: $responseStatus")
//             );
//           }
//         } else {
//           return ApiResult.failure(
//               error: NetworkExceptions.notFound("Status key is missing in JSON response")
//           );
//         }
//       } else {
//         return ApiResult.failure(
//             error: NetworkExceptions.notFound(response.reasonPhrase ?? "Incorrect")
//         );
//       }
//     } catch (e) {
//       print('Error uploading file: $e');
//       return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
//     }
//   }


  Future<ApiResult<LeaveApplications>> getLeaveApplications(
      BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_leave_form.php?EMPCODE=${authService.user?.userId ?? 000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: LeaveApplications.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<PasswordChangeModel>> changepassword(BuildContext context,
      String password) async {
    try {
      var response = await _apiClient?.getReq(
          "/change_password.php?emp_code=${authService.user?.userId ??
              000000}&new_password=$password"
      );
      print(response);
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: PasswordChangeModel.fromJson(data)

      );
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<String>> changephonenumber(BuildContext context,
      String number) async {
    try {
      var response = await _apiClient?.getReq(
          "/update_number.php?emp_code=${authService.user?.userId ??
              000000}&number=$number"
      );
      print(response);
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return
          ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['message']

      );
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }











  Future<ApiResult<Map<String, dynamic>>> applyLeave(BuildContext context,
      LeaveFormData formData) async {
    try {
      var response = await _apiClient?.getReq(
        "/apply_leave.php?FromDate=${formData.fromDate}&ToDate=${formData
            .toDate}&leave_type=${formData.leaveType}&emp_code=${authService
            .user?.userId}&emp_position=${formData
            .empPosition}&leave_reason=${formData.leaveReason}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        print("1");
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }

      print("2");
      return ApiResult.success(data: data);
    } catch (e) {
      print("3");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Visits>> getVisits(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_visit.php?EMPCODE=${authService.user?.userId ?? 000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect"));
      }
      print("2");
      return ApiResult.success(data: Visits.fromJson(data));
    } catch (e) {
      print("3");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<String>> applyVisit(BuildContext context,
      VisitFormData formData) async {
    try {
      var response = await _apiClient?.getReq(
        "/submit_visit.php?FromDate=${formData.fromDate}&ToDate=${formData
            .toDate}&emp_code=${formData.empCode}&lat=${formData
            .lat}&lon=${formData.lon}&visit_location=${formData
            .visitLocation}&visit_reason=${formData.visitReason}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(
            error: NetworkExceptions.notFound(
                response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['message']);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<CapexItems>> getCapexItems(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_capexitem_list.php",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: CapexItems.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<CapexForms>> getCapexForms(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_mycapexform.php?EMPCODE=${authService.user?.userId ?? 000000}",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: CapexForms.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<dynamic> capex(BuildContext context,
      List<Map<String, dynamic>> itemData, String capexType) async {
    var headers = {
      'Authorization': 'Basic RVNTOngyRnN0VnN5eg==',
      'Cookie': 'PHPSESSID=8p6vdf99d45ino2ct23fph4tgi'
    };


    var response = await _apiClient?.postReq(

        "/apply_capexform.php",
        data: {
          "emp_code": authService.user?.userId ?? 000000,
          "br_code": authService.user?.brcode,
          "capex_type": capexType,
          "itemdata": itemData
        },
        headers: headers

    );

    print("resposne: ${response!.data}");
    print('API response: ${response!.statusCode.toString()}');


    if (response?.statusCode == 200) {
      final responseBody = jsonDecode(response.data);
      //print('Response Body: $responseBody');
      // Parse and return the data
      return responseBody;
    } else {
      Constants.customErrorSnack(
          context, response?.message.toString() ?? "Unknown error");
      return null;
    }
    // } catch (e) {
    //
    //   return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    // }
  }

  Future<ApiResult<String>> applyCapex(BuildContext context,
      CapexFormData formData) async {
    try {
      var response = await _apiClient?.getReq(
        "/apply_capexform.php?capex_for=${formData.capexFor}&emp_code=${formData
            .empCode}&emp_name=${formData.empName}&emp_position=${formData
            .empPosition}&emp_branch=${formData.empBranch}&region=${formData
            .region}&department=${formData.department}&itemname=${formData
            .itemname}&qty=${formData.qty}",

      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['message']);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Branches>> getBranches(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_branchname.php",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Branches.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<Region>> getRegions(BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_regionname.php",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Region.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<WarehouseListResponse>> getwarehouse(
      BuildContext context) async
  {
    try {
      var response = await _apiClient?.getReq(
        "/qms/list_warehouses.php?brcode=${authService.user!.brcode}",);
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: WarehouseListResponse.fromJson(data));
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<List_temperature>> list_temperature_sheets(
      BuildContext context) async
  {
    try {
      var response = await _apiClient?.getReq(
        "https://premierspulse.com/ess/scripts/qms/list_temperature_sheets_si.php?emp_code=${authService.user!.userId}",);
      var data = jsonDecode(response?.data);
      print("data: ${data}");
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: List_temperature.fromJson(data));
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<List_temperature>> pharmacist_list(
      BuildContext context) async
  {
    try {
      var response = await _apiClient?.getReq(
        "https://premierspulse.com/ess/scripts/qms/list_temperature_sheets_pharma.php?emp_code=${authService.user!.userId}",);
      var data = jsonDecode(response?.data);
      print("data: ${data}");
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: List_temperature.fromJson(data));
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }








  Future<ApiResult<Map<String,dynamic>>> approval_temp(
      BuildContext context, String record_id, String status) async
  {
    try {
      var response = await _apiClient?.getReq(
        "/qms/update_si_status.php?record_id=${record_id}&status=${status}"
      );
      var data = jsonDecode(response?.data);
      print("data: ${data}");
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data);
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }
  Future<ApiResult<Map<String,dynamic>>> pharmacist_temp(
      BuildContext context, String record_id, String status) async
  {
    try {
      var response = await _apiClient?.getReq(
          "/qms/update_pharma_status.php?record_id=${record_id}&status=${status}"
      );
      var data = jsonDecode(response?.data);
      print("data: ${data}");
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data);
    }
    catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }











  Future<ApiResult<Map<String, dynamic>>> createsheet(BuildContext context, String warehouse_id, String room_lane, String month_year, String thermometer_no) async
  {
    try
    {
      var response = await _apiClient?.getReq("/qms/add_temp_sheet.php?branch_id=${authService.user!.brcode}&warehouse_id=${warehouse_id}&room_lane=${room_lane}&month_year=${month_year}&thermometer_no=${thermometer_no}&user_id=${authService.user!.userId}",);
      print("/qms/add_temp_sheet.php?branch_id=${authService.user!.brcode}&warehouse_id=${warehouse_id}&room_lane=${room_lane}&month_year=${month_year}&user_id=${authService.user!.userId}");
      var data = jsonDecode(response?.data);
      print(data);
      if (response?.statusCode != 200)
      {
        return ApiResult.failure(
            error:
            NetworkExceptions.notFound(response?.message ?? "Incorrect")
        );
      }
      return ApiResult.success(data: data);
    }
    catch (e)
    {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<Map<String, dynamic>>> warehouselist(BuildContext context,
      String warehouse_id, String room_lane, String month_year) async
  {
    try {
      var response = await _apiClient?.getReq(
        "/qms/add_temp_sheet.php?branch_id=${authService.user!
            .brcode}&warehouse_id=${warehouse_id}&room_lane=${room_lane}&month_year=${month_year}",);
      print("/qms/add_temp_sheet.php?branch_id=${authService.user!
          .brcode}&warehouse_id=${warehouse_id}&room_lane=${room_lane}&month_year=${month_year}");
      var data = jsonDecode(response?.data);
      print(data);
      if (response?.statusCode != 200)
      {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data);
    }
    catch (e)
    {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<WarehouseListModel>> warelist(BuildContext context) async
  {
    try

    {
      var response = await _apiClient?.getReq(
        "/qms/list_temperature_sheets.php?brcode=${authService.user!.brcode}",);
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200)
      {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: WarehouseListModel.fromJson(data));
      }
    catch (e)
      {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
      }}


  Future<ApiResult<Reservations>> getAllReservations(
      BuildContext context) async {
    try {
      var response = await _apiClient?.getReq(
        "/fetch_all_reservation.php",
      );
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: Reservations.fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<String>> reserveRoom(BuildContext context,
      ReservationFormData formData) async
  {
    try {
      var response =
      await _apiClient?.getReq(
        "/apply_board_reservation.php?board_room=${formData.boardRoom
            .toString()}&book_date=${formData.bookDate
            .toString()}&from_time=${formData.fromTime
            .toString()}&to_time=${formData.toTime
            .toString()}&emp_code=${formData.empCode
            .toString()}&remarks=${formData.remarks.toString()}&nop=${formData
            .nop.toString()}&agenda=${formData.agenda.toString()}",);
      var data = jsonDecode(response?.data);
      if (response?.statusCode != 200) {
        return ApiResult.failure(error: NetworkExceptions.notFound(
            response?.message ?? "Incorrect"));
      }
      return ApiResult.success(data: data['message']);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<String> submit_temp(
      String curr_temp,
      String max_temp,
      String min_temp,
      String curr_humidity,
      String max_humidity,
      String min_humidity,
      String sheetid,
      var tempimage,
      var humidityimage) async {
    try {
      var url =
          "https://premierspulse.com/ess/scripts/qms/record_temp_sheet.php?curr_temp=$curr_temp&max_temp=$max_temp&min_temp=$min_temp&curr_humidity=$curr_humidity&max_humidity=$max_humidity&min_humidity=$min_humidity&user_id=${authService.user!.userId}&sheet_id=$sheetid";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      print(url);

      // Add temp image if not null
      if (tempimage != null) {
        request.files.add(await http.MultipartFile.fromPath('file1', tempimage));
      }

      // Add humidity image if not null
      if (humidityimage != null) {
        request.files.add(await http.MultipartFile.fromPath('file2', humidityimage));
      }

      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      http.Client().close();

      var data = jsonDecode(response.body);

      if (myRequest.statusCode == 200) {
        String responseStatus = data["code"].toString();

        if (responseStatus == "200") {
          print(data);
          return data['msg'];
        }
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return e.toString();
    }
  }




}
