class director {
  director({
    required this.approvalListvisit,
  });

  late final List<directorForm> approvalListvisit;

  factory director.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['Forms'];
    final List<directorForm> parsedList = (rawList as List<dynamic>? ?? [])
        .map((e) => directorForm.fromJson(e))
        .toList();
    return director(approvalListvisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'Forms': approvalListvisit.map((e) => e.toJson()).toList(),
    };
  }
}

class directorForm {
  final String loanId;
  final String empCode;
  final String empName;
  final String attachmenturl;
  final String position;
  final String doj;
  final String loanType;
  final String department;
  final String branch;
  final String loanAmount;
  final String purpose;
  final String totalInstallment;
  final String perMonthRepay;
  final String hodStatus;
  final String hodName;
  final String directorStatus;
  final String ceoStatus;
  final String completePf;
  final String empShare;
  final String cmpShare;
  final String prvBalance;

  directorForm({
    required this.loanId,
    required this.empCode,
    required this.empName,
    required this.position,
    required this.doj,
    required this.attachmenturl,
    required this.loanType,
    required this.department,
    required this.branch,
    required this.loanAmount,
    required this.purpose,
    required this.totalInstallment,
    required this.perMonthRepay,
    required this.hodStatus,
    required this.hodName,
    required this.directorStatus,
    required this.ceoStatus,
    required this.completePf,
    required this.empShare,
    required this.cmpShare,
    required this.prvBalance,
  });

  factory directorForm.fromJson(Map<String, dynamic> json) {
    return directorForm(
      loanId: json['loan_id'],
      empCode: json['emp_code'],
      empName: json['emp_name'],
      position: json['position'],
      attachmenturl:json['attachmenturl'],
      doj: json['doj'],
      loanType: json['loantype'],
      department: json['department'],
      branch: json['branch'],
      loanAmount: json['loan_amount'],
      purpose: json['purpose'],
      totalInstallment: json['total_installment'],
      perMonthRepay: json['per_month_repay'],
      hodStatus: json['hod_status'],
      hodName: json['hod_name'],
      directorStatus: json['director_status'],
      ceoStatus: json['ceo_status'],
      completePf: json['complete_pf'],
      empShare: json['emp_share'],
      cmpShare: json['cmp_share'],
      prvBalance: json['prv_balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_id': loanId,
      'emp_code': empCode,
      'emp_name': empName,
      'position': position,
      'doj': doj,
      'loantype': loanType,
      'department': department,
      'branch': branch,
      'loan_amount': loanAmount,
      "attachmenturl":attachmenturl,
      'purpose': purpose,
      'total_installment': totalInstallment,
      'per_month_repay': perMonthRepay,
      'hod_status': hodStatus,
      'hod_name': hodName,
      'director_status': directorStatus,
      'ceo_status': ceoStatus,
      'complete_pf': completePf,
      'emp_share': empShare,
      'cmp_share': cmpShare,
      'prv_balance': prvBalance,
    };
  }
}
