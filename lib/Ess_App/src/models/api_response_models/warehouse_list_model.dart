class WarehouseListModel {
  String code;
  String msg;
  List<Warehouselist> datalist;

  WarehouseListModel({required this.code, required this.msg, required this.datalist});

  // Factory method to create WarehouseListModel from JSON
  factory WarehouseListModel.fromJson(Map<String, dynamic> json) {
    var list = json['Datalist'] as List;
    List<Warehouselist> warehouseList = list.map((i) => Warehouselist.fromJson(i)).toList();

    return WarehouseListModel(
      code: json['code'],
      msg: json['msg'],
      datalist: warehouseList,
    );
  }

  // Method to convert WarehouseListModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'Datalist': datalist.map((e) => e.toJson()).toList(),
    };
  }
}

// Warehouse class to represent each warehouse in the Datalist
class Warehouselist {
  String sheetId;
  String warehouseName;
  String roomLane;
  String monthYear;
  String thermometerNo;

  Warehouselist({
    required this.sheetId,
    required this.warehouseName,
    required this.roomLane,
    required this.monthYear,
    required this.thermometerNo,
  });

  // Factory method to create a Warehouse object from JSON
  factory Warehouselist.fromJson(Map<String, dynamic> json) {
    return Warehouselist(
      sheetId: json['sheet_id'],
      warehouseName: json['warehouse_name'],
      roomLane: json['room_lane'],
      monthYear: json['month_year'],
      thermometerNo: json['thermometer_no'],
    );
  }

  // Method to convert Warehouse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'sheet_id': sheetId,
      'warehouse_name': warehouseName,
      'room_lane': roomLane,
      'month_year': monthYear,
      'thermometer_no': thermometerNo,
    };
  }
}