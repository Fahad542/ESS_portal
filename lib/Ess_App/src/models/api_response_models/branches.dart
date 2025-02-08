class Branches {
  List<Datalist>? datalist;

  Branches({this.datalist});

  Branches.fromJson(Map<String, dynamic> json) {
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
  String? branchName;

  Datalist({this.branchName});

  Datalist.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    return data;
  }
}
