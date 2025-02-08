class Lmsloginmodel {
  final String memberId;
  final String memberName;
  final String mobile;

  Lmsloginmodel({
    required this.memberId,
    required this.memberName,
    required this.mobile,
  });

  factory Lmsloginmodel.fromJson(Map<String, dynamic> json) {
    return Lmsloginmodel(
      memberId: json['member_id'] ?? '',
      memberName: json['member_name'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'member_name': memberName,
      'mobile': mobile,
    };
  }
}

class LmsloginResponse {
  final List<Lmsloginmodel>? datalist; // Make it nullable
  final String code;
  final String msg;

  LmsloginResponse({
    this.datalist,
    required this.code,
    required this.msg,
  });

  factory LmsloginResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Datalist'] as List?;
    List<Lmsloginmodel>? userList = list?.map((i) => Lmsloginmodel.fromJson(i)).toList();

    return LmsloginResponse(
      datalist: userList,
      code: json['code'] ?? '',
      msg: json['msg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Datalist': datalist?.map((user) => user.toJson()).toList(),
      'code': code,
      'msg': msg,
    };
  }
}

