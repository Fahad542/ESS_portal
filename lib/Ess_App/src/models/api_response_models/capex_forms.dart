class CapexForms {
  List<Datalist>? datalist;

  CapexForms({this.datalist});

  CapexForms.fromJson(Map<String, dynamic> json) {
    if (json['Datalist'] != null) {
      datalist = <Datalist>[];
      json['Datalist'].forEach((v) {
        datalist!.add(new Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datalist != null) {
      data['Datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Datalist {
  String? capexId;
  String? capexDate;
  String? name;
  String? designation;
  String? branch;
  String? dept;
  String? capexFor;
  String? capexStatus;
  List<Itemdetail>? itemdetail;
  List<Approvaldetail>? approvaldetail;

  Datalist(
      {this.capexId,
        this.capexDate,
        this.name,
        this.designation,
        this.branch,
        this.dept,
        this.capexFor,
        this.capexStatus,
        this.itemdetail,
        this.approvaldetail});

  Datalist.fromJson(Map<String, dynamic> json) {
    capexId = json['capex_id'];
    capexDate = json['capex_date'];
    name = json['name'];
    designation = json['designation'];
    branch = json['branch'];
    dept = json['dept'];
    capexFor = json['capex_for'];
    capexStatus = json['capex_status'];
    if (json['itemdetail'] != null) {
      itemdetail = <Itemdetail>[];
      json['itemdetail'].forEach((v) {
        itemdetail!.add(new Itemdetail.fromJson(v));
      });
    }
    if (json['approvaldetail'] != null) {
      approvaldetail = <Approvaldetail>[];
      json['approvaldetail'].forEach((v) {
        approvaldetail!.add(new Approvaldetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capex_id'] = this.capexId;
    data['capex_date'] = this.capexDate;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['branch'] = this.branch;
    data['dept'] = this.dept;
    data['capex_for'] = this.capexFor;
    data['capex_status'] = this.capexStatus;
    if (this.itemdetail != null) {
      data['itemdetail'] = this.itemdetail!.map((v) => v.toJson()).toList();
    }
    if (this.approvaldetail != null) {
      data['approvaldetail'] =
          this.approvaldetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Itemdetail {
  String? item;
  String? qty;
  String? price;
  String? specs;

  Itemdetail({this.item, this.qty, this.price, this.specs});

  Itemdetail.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    qty = json['qty'];
    price = json['price'];
    specs = json['specs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['specs'] = this.specs;
    return data;
  }
}

class Approvaldetail {
  String? itApproval;
  String? hodApproval;
  String? directorApproval;
  String? date;

  Approvaldetail(
      {this.itApproval, this.hodApproval, this.directorApproval, this.date});

  Approvaldetail.fromJson(Map<String, dynamic> json) {
    itApproval = json['it_approval'];
    hodApproval = json['hod_approval'];
    directorApproval = json['director_approval'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['it_approval'] = this.itApproval;
    data['hod_approval'] = this.hodApproval;
    data['director_approval'] = this.directorApproval;
    data['date'] = this.date;
    return data;
  }
}

