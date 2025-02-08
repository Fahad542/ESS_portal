class FeedbackResponse {
  final String code;
  final String msg;
  final List<FeedbackTaker> feedbackTakers;

  FeedbackResponse({
    required this.code,
    required this.msg,
    required this.feedbackTakers,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Feedback_Takers'] as List;
    List<FeedbackTaker> feedbackTakersList = list.map((i) => FeedbackTaker.fromJson(i)).toList();

    return FeedbackResponse(
      code: json['code'],
      msg: json['Msg'],
      feedbackTakers: feedbackTakersList,
    );
  }
}

// Feedback taker model
class FeedbackTaker {
  final String empCode;
  final String username;
  final String feedbackGiven;

  FeedbackTaker({
    required this.empCode,
    required this.username,
    required this.feedbackGiven,
  });

  factory FeedbackTaker.fromJson(Map<String, dynamic> json) {
    return FeedbackTaker(
      empCode: json['emp_code'],
      username: json['username'],
      feedbackGiven: json['feedback_given'],
    );
  }
}
