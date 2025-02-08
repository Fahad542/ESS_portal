class Final_advance {
  List<finalItem> approvalItems;

  Final_advance({required this.approvalItems});

  factory Final_advance.fromJson(Map<String, dynamic> json) {
    var approvalItemsList = json['ApprovalList'] as List;
    List<finalItem> approvalItems = approvalItemsList.map((item) => finalItem.fromJson(item)).toList();

    return Final_advance(approvalItems: approvalItems);
  }
}

class finalItem {
  String visitId;
  String empName;
  String empCode;
  String postedDate;
  String reason;
  String amount;

  finalItem({
    required this.visitId,
    required this.empName,
    required this.empCode,
    required this.postedDate,
    required this.reason,
    required this.amount,
  });

  factory finalItem.fromJson(Map<String, dynamic> json) {
    return finalItem(
      visitId: json['visitid'],
      empName: json['emp_name'],
      empCode: json['emp_code'],
      postedDate: json['posted_date'],
      reason: json['reason'],
      amount: json['amount'],
    );
  }
}
