class goalmodel {
  goalmodel({
    required this.approvalListvisit,
  });

  late final List<goal> approvalListvisit;

  factory goalmodel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? rawList = json['Forms'];
    final List<goal> parsedList = (rawList as List<dynamic>? ?? [])
        .map((e) => goal.fromJson(e))
        .toList();
    return goalmodel(approvalListvisit: parsedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'Forms': approvalListvisit.map((e) => e.toJson()).toList(),
    };
  }
}




class goal {
  final String goal_id;
  final String goal_name;
  final String goal_detail;
  final String weightage;
  final String measures;




  goal({
    required this.goal_id,
    required this.goal_name,
    required this.goal_detail,
    required this.weightage,
    required this.measures


  });

  factory goal.fromJson(Map<String, dynamic> json) {
    return goal(
      goal_id: json['goal_id'],
      goal_name: json['goal_name'],
      goal_detail: json['goal_detail'],
      weightage: json['weightage'],
        measures:json['measures']


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goal_id': goal_id,
      'goal_name': goal_name,
      'goal_detail': goal_detail,
      'weightage': weightage,
      'measures':measures
    };
  }
}