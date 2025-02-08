// class LoanType {
//   final String loanTypeId;
//   final String loanTypeName;
//
//   LoanType({required this.loanTypeId, required this.loanTypeName});
//
//   factory LoanType.fromJson(Map<String, dynamic> json) {
//     return LoanType(
//       loanTypeId: json['loan_type_id'],
//       loanTypeName: json['loan_type_name'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'loan_type_id': loanTypeId,
//       'loan_type_name': loanTypeName,
//     };
//   }
// }
//
// class LoanData {
//   final List<LoanType> dataList;
//
//   LoanData({required this.dataList});
//
//   factory LoanData.fromJson(Map<String, dynamic> json) {
//     var dataListJson = json['Datalist'] as List;
//     List<LoanType> dataList =
//     dataListJson.map((loanTypeJson) => LoanType.fromJson(loanTypeJson)).toList();
//
//     return LoanData(dataList: dataList);
//   }
//
//   Map<String, dynamic> toJson() {
//     List<Map<String, dynamic>> dataListJson =
//     dataList.map((loanType) => loanType.toJson()).toList();
//
//     return {'Datalist': dataListJson};
//   }
// }



class LoanType {
  List<finalloan> approvalItems;

  LoanType({required this.approvalItems});

  factory LoanType.fromJson(Map<String, dynamic> json) {
    var approvalItemsList = json['Datalist'] as List;
    List<finalloan> approvalItems = approvalItemsList.map((item) => finalloan.fromJson(item)).toList();

    return LoanType(approvalItems: approvalItems);
  }
}

class finalloan {
  final String loanTypeId;
  final String loanTypeName;

  finalloan({
    required this.loanTypeId,
    required this.loanTypeName,

  });

  factory finalloan.fromJson(Map<String, dynamic> json) {
    return finalloan(
      loanTypeId: json['loan_type_id'],
      loanTypeName: json['loan_type_name'],

    );
  }
}
