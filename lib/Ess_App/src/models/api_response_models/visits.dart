class Visits {
  List<Datalist>? datalist;

  Visits({this.datalist});

  Visits.fromJson(Map<String, dynamic> json) {
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
  String? visitLocation;
  String? visitReason;
  String? visitDaterange;
  String? formFillDate;
  String? formStatus;
  String? approvedBy;

  Datalist(
      {this.visitLocation,
      this.visitReason,
      this.visitDaterange,
      this.formFillDate,
      this.formStatus,
      this.approvedBy});

  Datalist.fromJson(Map<String, dynamic> json) {
    visitLocation = json['visit_location'];
    visitReason = json['visit_reason'];
    visitDaterange = json['visit_daterange'];
    formFillDate = json['form_fill_date'];
    formStatus = json['form_status'];
    approvedBy = json['approved_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visit_location'] = this.visitLocation;
    data['visit_reason'] = this.visitReason;
    data['visit_daterange'] = this.visitDaterange;
    data['form_fill_date'] = this.formFillDate;
    data['form_status'] = this.formStatus;
    data['approved_by'] = this.approvedBy;
    return data;
  }
}
