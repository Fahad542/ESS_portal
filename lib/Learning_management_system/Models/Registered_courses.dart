class Registered_courses {
  final List<Res_Course> dataList;
  final String code;
  final String msg;

  Registered_courses({
    required this.dataList,
    required this.code,
    required this.msg,
  });

  factory Registered_courses.fromJson(Map<String, dynamic> json) {
    return Registered_courses(
      dataList: List<Res_Course>.from(json['Datalist'].map((item) => Res_Course.fromJson(item))),
      code: json['code'],
      msg: json['msg'],
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'Datalist': dataList.map((item) => item.toJson()).toList(),
      'code': code,
      'msg': msg,
    };
  }
}

class Res_Course {
  final String courseId;
  final String title;
  final String author;
  final String enrollmentDate;

  Res_Course ({
    required this.courseId,
    required this.title,
    required this.author,
    required this.enrollmentDate,
  });

  factory Res_Course .fromJson(Map<String, dynamic> json) {
    return Res_Course (
      courseId: json['course_id'],
      title: json['title'],
      author: json['author'],
      enrollmentDate: json['enrollment_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'title': title,
      'author': author,
      'enrollment_date': enrollmentDate,
    };
  }
}
