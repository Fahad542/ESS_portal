class advancelinemanagver {
  advancelinemanagver({
    required this.approvalListvisit,
  });

  late final List<finalloanList> approvalListvisit;

  factory advancelinemanagver.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['ApprovalList'];
    final List<finalloanList> parsedList = (rawList as List<dynamic>? ?? [])
        .map((e) => finalloanList.fromJson(e))
        .toList();
    return advancelinemanagver(approvalListvisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'ApprovalList': approvalListvisit.map((e) => e.toJson()).toList(),
    };
  }
}

class finalloanList {
  finalloanList({
    required this.case_id,
    required this.emp_code,
    required this.member_name,
    required this.amount,
    required this.case_date,
    required this.reason,
    required this.status,

  });
  late final String case_id;
  late final String emp_code;
  late final String member_name;
  late final String amount;
  late final String case_date;
  late final String reason;
  late final String status;

  factory finalloanList.fromJson(Map<String, dynamic> json) {
    return finalloanList(
        case_id: json['case_id'],
        emp_code: json['emp_code'],
        member_name: json['member_name'],
        amount: json['amount'],
        case_date: json['case_date'],
        reason: json['reason'],
        status: json['status'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case_id': case_id,
      'emp_code': emp_code,
      'member_name': member_name,
      'amount': amount,
      'case_date': case_date,
      'reason': reason,
      'status': status,

    };
  }
}
