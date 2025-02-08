class CapexFormData {
  String? capexFor;
  String? empCode;
  String? empName;
  String? empPosition;
  String? empBranch;
  String? region;
  String? department;
  String? itemname;
  String? qty;

  CapexFormData(
      {this.capexFor,
        this.empCode,
        this.empName,
        this.empPosition,
        this.empBranch,
        this.region,
        this.department,
        this.itemname,
        this.qty});

  CapexFormData.fromJson(Map<String, dynamic> json) {
    capexFor = json['capex_for'];
    empCode = json['emp_code'];
    empName = json['emp_name'];
    empPosition = json['emp_position'];
    empBranch = json['emp_branch'];
    region = json['region'];
    department = json['department'];
    itemname = json['itemname'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capex_for'] = this.capexFor;
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['emp_position'] = this.empPosition;
    data['emp_branch'] = this.empBranch;
    data['region'] = this.region;
    data['department'] = this.department;
    data['itemname'] = this.itemname;
    data['qty'] = this.qty;
    return data;
  }
}
