class fecthloan {
  fecthloan({
    required this.approvalListvisit,
  });

  late final List<loanList> approvalListvisit;

  factory fecthloan.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['Forms'];
    final List<loanList> parsedList = (rawList as List<dynamic>? ?? [])
        .map((e) => loanList.fromJson(e))
        .toList();
    return fecthloan(approvalListvisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'Forms': approvalListvisit.map((e) => e.toJson()).toList(),
    };
  }
}

class loanList {
  loanList({
    required this.loan_id,
    required this.emp_name,
    required this.emp_code,
    required this.position,
    required this.doj,
    required this.loantype,
    required this.loan_amount,
    required this.total_installment,
    required this.per_month_repay,
    required this.hod_status,
    required this.director_status,
    required this.ceo_status,
    required this.purpose,
  });
  late final String loan_id;
  late final String emp_name;
  late final String emp_code;
  late final String position;
  late final String doj;
  late final String loantype;
  late final String loan_amount;
  late final String total_installment;
  late final String per_month_repay;
  late final String hod_status;
  late final String director_status;
  late final String ceo_status;
  late final String purpose;
  factory loanList.fromJson(Map<String, dynamic> json) {
    return loanList(
      loan_id: json['loan_id'],
      emp_name: json['emp_name'],
      emp_code: json['emp_code'],
      position: json['position'],
      doj: json['doj'],
      loantype: json['loantype'],
      loan_amount: json['loan_amount'],
      total_installment: json['total_installment'],
      per_month_repay: json['per_month_repay'],
      hod_status: json['hod_status'],
      director_status: json['director_status'],
      ceo_status: json['ceo_status'],
      purpose: json['purpose']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_id': loan_id,
      'emp_name': emp_name,
      'emp_code': emp_code,
      'position': position,
      'doj': doj,
      'loantype': loantype,
      'loan_amount': loan_amount,
      'per_month_repay': per_month_repay,
      'total_installment': total_installment,
      'hod_status': hod_status,
      'director_status': director_status,
      'ceo_status': ceo_status,
      'purpose':purpose
    };
  }
}
