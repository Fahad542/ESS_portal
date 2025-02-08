class Batch {
  List<Item> datalist;

  Batch({required this.datalist});

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      datalist: List<Item>.from(json['Datalist'].map((item) => Item.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Datalist': List<dynamic>.from(datalist.map((item) => item.toJson())),
    };
  }
}

class Item {
  String id;
  String batch;

  Item({required this.id, required this.batch});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      batch: json['batch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'batch': batch,
    };
  }
}
