class FormsData {
  List<CapexModel> forms;

  FormsData({
    required this.forms,
  });

  factory FormsData.fromJson(Map<String, dynamic> json) {
    return FormsData(
      forms: (json['Forms'] as List<dynamic>)
          .map((form) => CapexModel.fromJson(form))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Forms': forms.map((form) => form.toJson()).toList(),
    };
  }
}



class CapexModel {
  String capexId;
  String empCode;
  String capexType;
  String brCode;
  String branchName;
  String postedDate;
  String memberName;
  String memberDesignation;
  String cordStatus;
  String hodStatus;
  String deptHeadStatus;
  String gmStatus;
  String ceoStatus;
  List<Items> itemList;

  CapexModel({
    required this.capexId,
    required this.empCode,
    required this.capexType,
    required this.brCode,
    required this.branchName,
    required this.postedDate,
    required this.memberName,
    required this.memberDesignation,
    required this.cordStatus,
    required this.hodStatus,
    required this.deptHeadStatus,
    required this.gmStatus,
    required this.ceoStatus,
    required this.itemList,
  });

  factory CapexModel.fromJson(Map<String, dynamic> json) {
    return CapexModel(
      capexId: json['capex_id'],
      empCode: json['emp_code'],
      capexType: json['capex_type'],
      brCode: json['brCode'],
      branchName: json['branch_name'],
      postedDate: json['posted_date'],
      memberName: json['member_name'],
      memberDesignation: json['member_designation'],
      cordStatus: json['cord_status'],
      hodStatus: json['hod_status'],
      deptHeadStatus: json['dept_head_status'],
      gmStatus: json['gm_status'],
      ceoStatus: json['ceo_status'],
      itemList: (json['itemlist'] as List<dynamic>)
          .map((item) => Items.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'capex_id': capexId,
      'emp_code': empCode,
      'capex_type': capexType,
      'brCode': brCode,
      'branch_name': branchName,
      'posted_date': postedDate,
      'member_name': memberName,
      'member_designation': memberDesignation,
      'cord_status': cordStatus,
      'hod_status': hodStatus,
      'dept_head_status': deptHeadStatus,
      'gm_status': gmStatus,
      'ceo_status': ceoStatus,
      'itemlist': itemList.map((item) => item.toJson()).toList(),
    };
  }
}

class Items {
  String itemName;
  String qty;
  String price;
  int total;

  Items({
    required this.itemName,
    required this.qty,
    required this.price,
    required this.total
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      itemName: json['item_name'],
      qty: json['qty'],
      price: json['price'],
        total: json['total']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'qty': qty,
      'price':price,
      'total':total


    };
  }
}