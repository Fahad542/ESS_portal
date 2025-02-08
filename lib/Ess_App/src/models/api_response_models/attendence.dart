class Attendance {
  List<Forms>? forms;
  UserInfo? userInfo;

  Attendance({this.forms, this.userInfo});

  Attendance.fromJson(Map<String, dynamic> json) {
    if (json['Forms'] != null) {
      forms = <Forms>[];
      json['Forms'].forEach((v) {
        forms!.add(new Forms.fromJson(v));
      });
    }
    userInfo = json['UserInfo'] != null
        ? new UserInfo.fromJson(json['UserInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forms != null) {
      data['Forms'] = this.forms!.map((v) => v.toJson()).toList();
    }
    if (this.userInfo != null) {
      data['UserInfo'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class Forms {
  String? attendDate;
  String? checkIn;
  String? checkOut;
  String? attendStatus;
  String? attendDay;

  Forms(
      {this.attendDate,
      this.checkIn,
      this.checkOut,
      this.attendStatus,
      this.attendDay
      }
      );

  Forms.fromJson(Map<String, dynamic> json) {
    attendDate = json['attend_date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    attendStatus = json['attend_status'];
    attendDay = json['attend_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attend_date'] = this.attendDate;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['attend_status'] = this.attendStatus;
    data['attend_day'] = this.attendDay;
    return data;
  }
}

class UserInfo {
  String? memberCode;
  String? username;
  String? email;
  String? casualLeaves;
  String? sickLeaves;
  String? annualLeaves;
  String? totalLates;
  String? totalOntime;

  UserInfo(
      {this.memberCode,
      this.username,
      this.email,
      this.casualLeaves,
      this.sickLeaves,
      this.annualLeaves,
      this.totalLates,
      this.totalOntime});

  UserInfo.fromJson(Map<String, dynamic> json) {
    memberCode = json['member_code'];
    username = json['username'];
    email = json['email'];
    casualLeaves = json['casual_leaves'];
    sickLeaves = json['sick_leaves'];
    annualLeaves = json['annual_leaves'];
    totalLates = json['total_lates'];
    totalOntime = json['total_ontime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_code'] = this.memberCode;
    data['username'] = this.username;
    data['email'] = this.email;
    data['casual_leaves'] = this.casualLeaves;
    data['sick_leaves'] = this.sickLeaves;
    data['annual_leaves'] = this.annualLeaves;
    data['total_lates'] = this.totalLates;
    data['total_ontime'] = this.totalOntime;
    return data;
  }
}
