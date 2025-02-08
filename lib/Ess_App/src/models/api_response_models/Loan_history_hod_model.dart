class fecthhistory {

  fecthhistory({
    required this.approvalListvisit,
  });

  late final List<LoanForm> approvalListvisit;

  factory fecthhistory.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['Forms'];
    final List<LoanForm> parsedList = (rawList as List<dynamic>? ?? [])
        .map((e) => LoanForm.fromJson(e))
        .toList();
    return fecthhistory(approvalListvisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'Forms': approvalListvisit.map((e) => e.toJson()).toList(),
    };
  }
}

class LoanForm {
  final String loanId;
  final String empCode;
  final String empName;
  final String position;
  final String doj;
  final String loanType;
  final String loanAmount;
  final String purpose;
  final String totalInstallment;
  final String perMonthRepay;
  final String hodStatus;
  final String directorStatus;
  final String ceoStatus;
  final String status;
  final String completePf;
  final String empShare;
  final String cmpShare;
  final String prvBalance;

  LoanForm({
    required this.loanId,
    required this.empCode,
    required this.empName,
    required this.position,
    required this.doj,
    required this.loanType,
    required this.loanAmount,
    required this.purpose,
    required this.totalInstallment,
    required this.perMonthRepay,
    required this.hodStatus,
    required this.directorStatus,
    required this.ceoStatus,
    required this.status,
    required this.completePf,
    required this.empShare,
    required this.cmpShare,
    required this.prvBalance,
  });

  factory LoanForm.fromJson(Map<String, dynamic> json) {
    return LoanForm(
      loanId: json['loan_id'],
      empCode: json['emp_code'],
      empName: json['emp_name'],
      position: json['position'],
      doj: json['doj'],
      loanType: json['loantype'],
      loanAmount: json['loan_amount'],
      purpose: json['purpose'],
      totalInstallment: json['total_installment'],
      perMonthRepay: json['per_month_repay'],
      hodStatus: json['hod_status'],
      directorStatus: json['director_status'],
      ceoStatus: json['ceo_status'],
      status: json['status'],
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
      'loan_amount': loanAmount,
      'purpose': purpose,
      'total_installment': totalInstallment,
      'per_month_repay': perMonthRepay,
      'hod_status': hodStatus,
      'director_status': directorStatus,
      'ceo_status': ceoStatus,
      'status': status,
      'complete_pf': completePf,
      'emp_share': empShare,
      'cmp_share': cmpShare,
      'prv_balance': prvBalance,
    };
  }
}
