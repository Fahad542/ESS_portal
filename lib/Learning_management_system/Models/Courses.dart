class Course {
  final String id;
  final String title;
  final String duration;
  final String categoryId;
  final String summary;
  final String featureImage;
  final String author;
  final String isFeature;
  final String status;

  Course({
    required this.id,
    required this.title,
    required this.duration,
    required this.categoryId,
    required this.summary,
    required this.featureImage,
    required this.author,
    required this.isFeature,
    required this.status,
  });

  // Factory method to create a Course object from a JSON map
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      title: json['title']?? '',
      duration: json['duration']?? '',
      categoryId: json['category_id']?? '',
      summary: json['summary']?? '',
      featureImage: json['feature_image']?? '',
      author: json['author']?? '',
      isFeature: json['is_feature']?? '',
      status: json['status']?? '',
    );
  }
}

class CourseResponse {
  final List<Course> dataList;
  final String code;
  final String msg;

  CourseResponse({
    required this.dataList,
    required this.code,
    required this.msg,
  });

  // Factory method to create a CourseResponse object from a JSON map
  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Datalist'] as List;
    List<Course> courses = list.map((i) => Course.fromJson(i)).toList();

    return CourseResponse(
      dataList: courses,
      code: json['code'],
      msg: json['msg'],
    );
  }
}
