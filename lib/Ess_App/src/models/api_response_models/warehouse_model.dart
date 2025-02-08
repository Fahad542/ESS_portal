class WarehouseListResponse {
  final String code;
  final String msg;
  final List<Warehouse> datalist;

  WarehouseListResponse({
    required this.code,
    required this.msg,
    required this.datalist,
  });

  factory WarehouseListResponse.fromJson(Map<String, dynamic> json) {
    return WarehouseListResponse(
      code: json['code'],
      msg: json['msg'],
      datalist: (json['Datalist'] as List)
          .map((item) => Warehouse.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'Datalist': datalist.map((warehouse) => warehouse.toJson()).toList(),
    };
  }
}

class Warehouse {
  final String warehouseId;
  final String warehouseName;

  Warehouse({
    required this.warehouseId,
    required this.warehouseName,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      warehouseId: json['warehouse_id'],
      warehouseName: json['warehouse_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'warehouse_id': warehouseId,
      'warehouse_name': warehouseName,
    };
  }
}
