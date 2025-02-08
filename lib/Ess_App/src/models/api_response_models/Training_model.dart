class FormsModel {
  List<Trainings> forms;

  FormsModel({required this.forms});

  factory FormsModel.fromJson(Map<String, dynamic> json) {
    return FormsModel(
      forms: List<Trainings>.from(json['Forms'].map((x) => Trainings.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Forms': List<dynamic>.from(forms.map((x) => x.toJson())),
    };
  }
}

class Trainings {
  String training;

  Trainings({required this.training});

  factory Trainings.fromJson(Map<String, dynamic> json) {
    return Trainings(
      training: json['training'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'training': training,
    };
  }
}
