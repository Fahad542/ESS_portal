class PendingGuarantee {
  PendingGuarantee({
    required this.approvalListVisit,
  });

  final List<Pending> approvalListVisit;

  factory PendingGuarantee.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawList = json['ApprovalList'] ?? [];
    final List<Pending> parsedList = rawList.map((e) => Pending.fromJson(e)).toList();
    return PendingGuarantee(approvalListVisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'ApprovalList': approvalListVisit.map((e) => e.toJson()).toList(),
    };
  }
}

class Pending {
  Pending({
    required this.loanId,
    required this.empName,
    required this.position,
    required this.mobile,
    required this.doj,
    required this.department,
    required this.loanType,
    required this.loan,
    required this.applicantType,
    required this.repay,
    required this.repayRs,
    required this.branchOnly,
    required this.guarantor,
    required this.loanInWords,
  });

  final String? loanId;
  final String empName;
  final String position;
  final String mobile;
  final String doj;
  final String department;
  final String loanType;
  final String loan;
  final String repay;
  final String applicantType;
  final String? branchOnly;
  final int guarantor;
  final String repayRs;
  final String loanInWords;

  factory Pending.fromJson(Map<String, dynamic> json) {
    return Pending(
      loanId: json['loanid'] as String?,
      empName: json['emp_name'] as String,
      position: json['position'] as String,
      mobile: json['mobile'] as String,
      doj: json['doj'] as String,
      department: json['department'] as String,
      loanType: json['loantype'] as String,
      loan: json['loan'] as String,
      applicantType: json['applicanttype'] as String,
      repay: json['repay'] as String,
      branchOnly: json['branchonly'] as String?,
      guarantor: json['guarantor'] as int,
      repayRs: json['repayrs'] as String,
      loanInWords: json['loaninwords'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loanid': loanId,
      'emp_name': empName,
      'position': position,
      'mobile': mobile,
      'doj': doj,
      'department': department,
      'loantype': loanType,
      'loan': loan,
      'applicanttype': applicantType,
      'repay': repay,
      'branchonly': branchOnly,
      'guarantor': guarantor,
      'repayrs': repayRs,
      'loaninwords': loanInWords,
    };
  }
}
