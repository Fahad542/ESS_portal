

class QuestionsResponse {
  final String code;
  final String msg;
  final List<Question> questions;

  QuestionsResponse({
    required this.code,
    required this.msg,
    required this.questions,
  });

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) {
    var questionsList = json['Questions'] as List;
    List<Question> questions =
    questionsList.map((i) => Question.fromJson(i)).toList();

    return QuestionsResponse(
      code: json['code'],
      msg: json['Msg'],
      questions: questions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'Msg': msg,
      'Questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class Question {
  final String id;
  final String question;
  final String category;
  final String status;
  final String urdu;

  Question({
    required this.id,
    required this.question,
    required this.category,
    required this.status,
    required this.urdu,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      category: json['category'],
      status: json['status'],
      urdu: json['urdu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'category': category,
      'status': status,
      'urdu': urdu,
    };
  }
}
