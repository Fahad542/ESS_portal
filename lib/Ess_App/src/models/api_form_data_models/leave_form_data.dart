class LeaveFormData {
  String? fromDate;
  String? toDate;
  String? leaveType;
  String? empCode;
  String? empPosition;
  String? leaveReason;

  LeaveFormData(
      {this.fromDate,
        this.toDate,
        this.leaveType,
        this.empCode,
        this.empPosition,
        this.leaveReason});

  LeaveFormData.fromJson(Map<String, dynamic> json) {
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    leaveType = json['leave_type'];
    empCode = json['emp_code'];
    empPosition = json['emp_position'];
    leaveReason = json['leave_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['leave_type'] = this.leaveType;
    data['emp_code'] = this.empCode;
    data['emp_position'] = this.empPosition;
    data['leave_reason'] = this.leaveReason;
    return data;
  }
}
