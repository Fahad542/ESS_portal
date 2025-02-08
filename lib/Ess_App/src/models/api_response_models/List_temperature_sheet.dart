class List_temperature {
  final String code;
  final String msg;
  final List<Warehousetemp> datalist;

  List_temperature({
    required this.code,
    required this.msg,
    required this.datalist,
  });

  // Factory method to create an instance from JSON
  factory List_temperature.fromJson(Map<String, dynamic> json) {
    return List_temperature(
      code: json['code'],
      msg: json['msg'],
      datalist: (json['Datalist'] as List)
          .map((item) => Warehousetemp.fromJson(item))
          .toList(),
    );
  }
}

class Warehousetemp {
  final String id;
  final String date;
  final String curTemp;
  final String maxTemp;
  final String minTemp;
  final String currHumidity;
  final String maxHumidity;
  final String minHumidity;
  final String warehouse;
  final String room;
  final String thermometerNo;
  final String monthYear;
  final String attach1;
  final String attach2;

  Warehousetemp({
    required this.id,
    required this.date,
    required this.curTemp,
    required this.maxTemp,
    required this.minTemp,
    required this.currHumidity,
    required this.maxHumidity,
    required this.minHumidity,
    required this.warehouse,
    required this.room,
    required this.thermometerNo,
    required this.monthYear,
    required this.attach1,
    required this.attach2,
  });

  // Factory method to create an instance from JSON
  factory Warehousetemp.fromJson(Map<String, dynamic> json) {
    return Warehousetemp(
      id: json['record_id'],
      date: json['date'],
      curTemp: json['cur_temp'],
      maxTemp: json['max_temp'],
      minTemp: json['min_temp'],
      currHumidity: json['curr_humidity'],
      maxHumidity: json['max_humidity'],
      minHumidity: json['min_humidity'],
      warehouse: json['warehouse'],
      room: json['room'],
      thermometerNo: json['thermometer_no'],
      monthYear: json['month_year'],
      attach1: json['attach_1'],
      attach2: json['attach_2'],
    );
  }
}
