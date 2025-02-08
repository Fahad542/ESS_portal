class guaranter {
  List<finalguaranter> approvalItems;

  guaranter({required this.approvalItems});

  factory guaranter.fromJson(Map<String, dynamic> json) {
    var approvalItemsList = json['Datalist'] as List;
    List<finalguaranter> approvalItems = approvalItemsList.map((item) => finalguaranter.fromJson(item)).toList();

    return guaranter(approvalItems: approvalItems);
  }
}

class finalguaranter {
  final String member_code;
  final String member_name;


  finalguaranter({
    required this.member_code,
    required this.member_name,


  });

  factory finalguaranter.fromJson(Map<String, dynamic> json) {
    return finalguaranter(
      member_code: json['member_code'],
      member_name: json['member_name'],


    );
  }
}
