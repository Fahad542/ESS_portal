
// class VisitApprovalList {
//   VisitApprovalList({
//     required this.visitList,
//   });
//
//   late final List<ApprovalVisitList> visitList;
//
//   factory VisitApprovalList.fromJson(Map<String, dynamic> json) {
//     final List<dynamic>? rawList = json['ApprovalList'];
//     final List<ApprovalVisitList> parsedList =
//     (rawList as List<dynamic>? ?? []).map((e) => ApprovalVisitList.fromJson(e)).toList();
//     return VisitApprovalList(visitList: parsedList);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'ApprovalList': visitList.map((e) => e.toJson()).toList(),
//     };
//   }
// }
//
// class ApprovalVisitList {
//   ApprovalVisitList({
//     required this.visitid,
//     required this.name,
//     required this.emp_code,
//     required this.date_to,
//     required this.reason,
//     required this.location,
//     required this.lat,
//     required this.lon,
//   });
//
//   late final String visitid;
//   late final String name;
//   late final String emp_code;
//   late final String date_to;
//   late final String reason;
//   late final String location;
//   late final String lat;
//   late final String lon;
//
//   factory ApprovalVisitList.fromJson(Map<String, dynamic> json) {
//     return ApprovalVisitList(
//       visitid: json['visitid'],
//       name: json['name'],
//       emp_code: json['emp_code'],
//       date_to: json['date_to'],
//       reason: json['reason'],
//       location: json['location'],
//       lat: json['lat'],
//       lon: json['lon'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'visitid': visitid,
//       'name': name,
//       'emp_code': emp_code,
//       'date_to': date_to,
//       'reason': reason,
//       'location': location,
//       'lat': lat,
//       'lon': lon,
//     };
//   }
// }

class UsermodelVisit {
  UsermodelVisit({
    required this.approvalListvisit,
  });

  late final List<ApprovalVisitList> approvalListvisit;

  factory UsermodelVisit.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['ApprovalList'];
    final List<ApprovalVisitList> parsedList =
    (rawList as List<dynamic>? ?? []).map((e) => ApprovalVisitList.fromJson(e)).toList();
    return UsermodelVisit(approvalListvisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'ApprovalList': approvalListvisit.map((e) => e.toJson()).toList(),
    };
  }
}

class ApprovalVisitList {
  ApprovalVisitList({
    required this.visitid,
    required this.name,
    required this.emp_code,
    required this.date_to,
    required this.reason,
    required this.location,
    required this.lat,
    required this.lon,
  });
  late final String visitid;
  late final String name;
  late final String emp_code;
  late final String date_to;
  late final String reason;
  late final String location;
  late final String lat;
  late final String lon;

  factory ApprovalVisitList.fromJson(Map<String, dynamic> json) {
    return ApprovalVisitList(
      visitid: json['visitid'],
      name: json['name'],
      emp_code: json['emp_code'],
      date_to: json['date_to'],
      reason: json['reason'],
      location: json['location'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitid': visitid,
      'name': name,
      'emp_code': emp_code,
      'date_to': date_to,
      'reason': reason,
      'location': location,
      'lat': lat,
      'lon': lon,
    };
  }
}
