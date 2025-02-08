class LoginResponse {
  final Data data;

  LoginResponse({required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Data {
  final String? code;
  final String? loginMsg;
  final String? username;
  final String? empCode;

  Data({
    required this.code,
    required this.loginMsg,
    required this.username,
    required this.empCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      code: json['code'].toString(),
      loginMsg: json['LoginMsg'].toString(),
      username: json['username'].toString(),
      empCode: json['emp_code'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'LoginMsg': loginMsg,
      'username': username,
      'emp_code': empCode,
    };
  }
}
