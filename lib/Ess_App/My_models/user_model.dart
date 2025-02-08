

class Usermodel {
  Usermodel({
    required this.approvalList,
  });

  late final List<ApprovalList> approvalList;

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    // Safe parsing of the 'ApprovalList' field, handling potential nulls
    final List<dynamic>? rawList = json['ApprovalList'];
    final List<ApprovalList> parsedList = (rawList ?? [])
        .map((e) => ApprovalList.fromJson(e ?? {}))  // Safely handle individual ApprovalList items
        .toList();
    return Usermodel(approvalList: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'ApprovalList': approvalList.map((e) => e.toJson()).toList(),
    };
  }
}

class ApprovalList {
  ApprovalList({
    required this.leaveid,
    required this.name,
    required this.code,
    required this.fromLeave,
    required this.toLeave,
    required this.days,
    required this.reason,
    required this.type,
  });

  late final String leaveid;
  late final String name;
  late final String code;
  late final String fromLeave;
  late final String toLeave;
  late final String days;
  late final String reason;
  late final String type;

  factory ApprovalList.fromJson(Map<String, dynamic> json) {
    return ApprovalList(
      // Providing default empty strings or other fallback values for potential null fields
      leaveid: json['leaveid'] ?? '',  // Default to an empty string if null
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      fromLeave: json['from_leave'] ?? '',
      toLeave: json['to_leave'] ?? '',
      days: json['days'] ?? '',
      reason: json['reason'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leaveid': leaveid,
      'name': name,
      'code': code,
      'from_leave': fromLeave,
      'to_leave': toLeave,
      'days': days,
      'reason': reason,
      'type': type,
    };
  }
}
