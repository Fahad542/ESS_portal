class SurveyDashboard {
  final String code;
  final String msg;
  final String stronglyAgree;
  final String agree;
  final String disAgree;
  final String stronglyDisagree;

  SurveyDashboard({
    required this.code,
    required this.msg,
    required this.stronglyAgree,
    required this.agree,
    required this.disAgree,
    required this.stronglyDisagree,
  });

  factory SurveyDashboard.fromJson(Map<String, dynamic> json) {
    return SurveyDashboard(
      code: json['code'],
      msg: json['Msg'],
      stronglyAgree: json['stronglyAgree'],
      agree: json['agree'],
      disAgree: json['disAgree'],
      stronglyDisagree: json['stronglyDisagree'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'Msg': msg,
      'stronglyAgree': stronglyAgree,
      'agree': agree,
      'disAgree': disAgree,
      'stronglyDisagree': stronglyDisagree,
    };
  }
}
