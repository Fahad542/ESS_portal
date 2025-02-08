class Training {
  String trainings;

  Training({required this.trainings});

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      trainings: json['trainings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trainings': trainings,
    };
  }
}

class TrainingList {
  List<Training> datalist;

  TrainingList({required this.datalist});

  factory TrainingList.fromJson(Map<String, dynamic> json) {
    return TrainingList(
      datalist: (json['Datalist'] as List)
          .map((i) => Training.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Datalist': datalist.map((training) => training.toJson()).toList(),
    };
  }
}
