class VisitFormData {
  String? fromDate;
  String? toDate;
  String? empCode;
  String? lat;
  String? lon;
  String? visitLocation;
  String? visitReason;

  VisitFormData(
      {this.fromDate,
        this.toDate,
        this.empCode,
        this.lat,
        this.lon,
        this.visitLocation,
        this.visitReason});

  VisitFormData.fromJson(Map<String, dynamic> json) {
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    empCode = json['emp_code'];
    lat = json['lat'];
    lon = json['lon'];
    visitLocation = json['visit_location'];
    visitReason = json['visit_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['emp_code'] = this.empCode;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['visit_location'] = this.visitLocation;
    data['visit_reason'] = this.visitReason;
    return data;
  }
}
