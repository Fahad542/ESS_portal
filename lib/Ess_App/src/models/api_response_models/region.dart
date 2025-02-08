class Region {
  List<Datalist>? datalist;

  Region({this.datalist});

  Region.fromJson(Map<String, dynamic> json) {
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
  String? regionName;

  Datalist({this.regionName});

  Datalist.fromJson(Map<String, dynamic> json) {
    regionName = json['region_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_name'] = this.regionName;
    return data;
  }
}
