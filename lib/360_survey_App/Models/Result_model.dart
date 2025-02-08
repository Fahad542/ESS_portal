class ResultModel {
  final String? code;
  final String? loginMsg;
  final String? stronglyAgree;
  final String? agree;
  final String? disAgree;
  final String? stronglyDisagree;
  final List<String> comments;

  ResultModel({
    required this.code,
    required this.loginMsg,
    required this.stronglyAgree,
    required this.agree,
    required this.disAgree,
    required this.stronglyDisagree,
   required this.comments,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      code: json['code'],
      loginMsg: json['LoginMsg'],
      stronglyAgree: json['stronglyAgree'],
      agree: json['agree'],
      disAgree: json['disAgree'],
      stronglyDisagree: json['stronglyDisagree'],
      comments: List<String>.from(json['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'LoginMsg': loginMsg,
      'stronglyAgree': stronglyAgree,
      'agree': agree,
      'disAgree': disAgree,
      'stronglyDisagree': stronglyDisagree,
      'comments': comments,
    };
  }
}

