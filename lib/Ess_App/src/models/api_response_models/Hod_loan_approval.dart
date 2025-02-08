class hodloanmodel {
  hodloanmodel({
    required this.approvalListvisit,
  });

  late final List<LoanForm> approvalListvisit;

  factory hodloanmodel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['Forms'];
    final List<LoanForm> parsedList = (rawList as List<dynamic>? ?? [])
        .map((e) => LoanForm.fromJson(e))
        .toList();
    return hodloanmodel(approvalListvisit: parsedList);
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
  final String department;
  final String branch;
  final String loanAmount;
  final String purpose;
  final String totalInstallment;
  final String perMonthRepay;
  final String hodStatus;
  final String attachmenturl;
  final String directorStatus;
  final String ceoStatus;
  final String completePf;
  final String empShare;
  final String cmpShare;
  final String prvBalance;
  final List<LoanComment> loanComments;

  LoanForm({
    required this.loanId,
    required this.empCode,
    required this.empName,
    required this.position,
    required this.doj,
    required this.loanType,
    required this.department,
    required this.branch,
    required this.loanAmount,
    required this.purpose,
    required this.totalInstallment,
    required this.perMonthRepay,
    required this.hodStatus,
    required this.directorStatus,
    required this.ceoStatus,
    required this.attachmenturl,
    required this.completePf,
    required this.empShare,
    required this.cmpShare,
    required this.prvBalance,
    required this.loanComments,
  });

  factory LoanForm.fromJson(Map<String, dynamic> json) {
    return LoanForm(
      loanId: json['loan_id'],
      empCode: json['emp_code'],
      empName: json['emp_name'],
      position: json['position'],
      doj: json['doj'],
      attachmenturl: json['attachmenturl'],
      loanType: json['loantype'],
      department: json['department'],
      branch: json['branch'],
      loanAmount: json['loan_amount'],
      purpose: json['purpose'],
      totalInstallment: json['total_installment'],
      perMonthRepay: json['per_month_repay'],
      hodStatus: json['hod_status'],
      directorStatus: json['director_status'],
      ceoStatus: json['ceo_status'],
      completePf: json['complete_pf'],
      empShare: json['emp_share'],
      cmpShare: json['cmp_share'],
      prvBalance: json['prv_balance'],
      loanComments: (json['loancomments'] as List)
          .map((comment) => LoanComment.fromJson(comment))
          .toList(),
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
      'purpose': purpose,
      'total_installment': totalInstallment,
      'per_month_repay': perMonthRepay,
      'hod_status': hodStatus,
      "attachmenturl":attachmenturl,
      'director_status': directorStatus,
      'ceo_status': ceoStatus,
      'complete_pf': completePf,
      'emp_share': empShare,
      'cmp_share': cmpShare,
      'prv_balance': prvBalance,
      'loancomments': loanComments.map((comment) => comment.toJson()).toList(),
    };
  }
}

class LoanComment {
  final String comments;
  final String postedBy;

  LoanComment({
    required this.comments,
    required this.postedBy,
  });

  factory LoanComment.fromJson(Map<String, dynamic> json) {
    return LoanComment(
      comments: json['coments'],
      postedBy: json['posted_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coments': comments,
      'posted_by': postedBy,
    };
  }
}
