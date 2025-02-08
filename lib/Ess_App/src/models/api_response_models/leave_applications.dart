class LeaveApplications {
  List<LeaveForms>? forms;

  LeaveApplications({this.forms});

  LeaveApplications.fromJson(Map<String, dynamic> json) {
    if (json['Forms'] != null) {
      forms = <LeaveForms>[];
      json['Forms'].forEach((v) {
        forms!.add(new LeaveForms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forms != null) {
      data['Forms'] = this.forms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveForms {
  String? name;
  String? date;
  String? statusType;
  String? leaveDaterange;
  String? sickLeave;
  String? casualLeave;
  String? annualLeave;

  LeaveForms(
      {this.name,
      this.date,
      this.statusType,
      this.leaveDaterange,
      this.sickLeave,
      this.casualLeave,
      this.annualLeave});

  LeaveForms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    statusType = json['status_type'];
    leaveDaterange = json['leave_daterange'];
    sickLeave = json['sick_leave'];
    casualLeave = json['casual_leave'];
    annualLeave = json['annual_leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['status_type'] = this.statusType;
    data['leave_daterange'] = this.leaveDaterange;
    data['sick_leave'] = this.sickLeave;
    data['casual_leave'] = this.casualLeave;
    data['annual_leave'] = this.annualLeave;
    return data;
  }
}
