class CapexItems {
  List<Datalist>? datalist;

  CapexItems({this.datalist});

  CapexItems.fromJson(Map<String, dynamic> json) {
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
  String? itemName;
  String? id;
  String? Category;

  Datalist({this.itemName, this.id, this.Category});

  Datalist.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    id = json['id'];
    Category = json['category'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['id'] = this.id;
    data['category'] = this.Category;
    return data;
  }
}