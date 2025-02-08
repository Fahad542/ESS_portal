class branch {
  List<finalbranch> approvalItems;

  branch({required this.approvalItems});

  factory branch.fromJson(Map<String, dynamic> json) {
    var approvalItemsList = json['Datalist'] as List;
    List<finalbranch> approvalItems = approvalItemsList.map((item) => finalbranch.fromJson(item)).toList();

    return branch(approvalItems: approvalItems);
  }
}

class finalbranch {
  final String branch_name;
  final String bms_code;


  finalbranch({
    required this.branch_name,
    required this.bms_code,


  });

  factory finalbranch.fromJson(Map<String, dynamic> json) {
    return finalbranch(
      branch_name: json['branch_name'],
      bms_code: json['bms_code'],


    );
  }
}
