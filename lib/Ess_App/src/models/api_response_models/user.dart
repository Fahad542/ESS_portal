class User {
  String? casualLeaves;
  String? sickLeaves;
  String? annualLeaves;
  String? userId;
  String? userName;
  String? email;
  String? loginStatus;
  String? loginMsg;
  String? AdvFinApp;
  String? brcode;
  String? member_designation;
  String? role;
  String? memberAccess;
  String? att_lat;
  String? att_lon;
  String? radius;
  String? dob;
  int? is_qms;

  User(
      {this.casualLeaves,
      this.sickLeaves,
      this.annualLeaves,
      this.userId,
      this.userName,
      this.email,
      this.loginStatus,
      this.loginMsg,
      this.AdvFinApp,
         this.brcode,
        this.member_designation,
         this.role,
        this.memberAccess,
        this.att_lat,
        this.att_lon,
        this.radius,
        this.dob,
        this.is_qms
      });

  User.fromJson(Map<String, dynamic> json) {
    casualLeaves = json['casual_leaves'];
    sickLeaves = json['sick_leaves'];
    annualLeaves = json['annual_leaves'];
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    loginStatus = json['LoginStatus'];
    loginMsg = json['LoginMsg'];
    AdvFinApp=json['AdvFinApp'];
    brcode=json['brcode'];
    member_designation=json['member_designation'];
    role=json['role'];
    memberAccess=json['memberAccess'];
    att_lat=json['att_lat'];
    att_lon=json['att_lon'];
    radius=json['radius'];
    dob= json['dob'];
    is_qms= json['is_qms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['casual_leaves'] = this.casualLeaves;
    data['sick_leaves'] = this.sickLeaves;
    data['annual_leaves'] = this.annualLeaves;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['LoginStatus'] = this.loginStatus;
    data['LoginMsg'] = this.loginMsg;
    data['AdvFinApp']=this.AdvFinApp;
    data['brcode']=this.brcode;
    data['member_designation']=this.member_designation;
    data['role']=this.role;
    data['memberAccess']=this.memberAccess;
    data['att_lat']=this.att_lat;
    data['att_lon']=this.att_lon;
    data['radius']=this.radius;
    data['dob']=this.dob;
    data['is_qms']=this.is_qms;
    return data;
  }
}
