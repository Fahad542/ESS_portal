class stat1 {
  final String code;
  final String msg;
  final int stronglyAgreeCat1;
  final int agreeCat1;
  final int disagreeCat1;
  final int stronglyDisagreeCat1;

  stat1({
    required this.code,
    required this.msg,
    required this.stronglyAgreeCat1,
    required this.agreeCat1,
    required this.disagreeCat1,
    required this.stronglyDisagreeCat1,
  });

  factory stat1.fromJson(Map<String, dynamic> json) {
    return stat1(
      code: json['code'],
      msg: json['Msg'],
      stronglyAgreeCat1: int.parse(json['StronglyAgreeCat1']),
      agreeCat1: int.parse(json['AgreeCat1']),
      disagreeCat1: int.parse(json['DisAgreeCat1']),
      stronglyDisagreeCat1: int.parse(json['StronglyDisAgreeCat1']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'Msg': msg,
      'StronglyAgreeCat1': stronglyAgreeCat1.toString(),
      'AgreeCat1': agreeCat1.toString(),
      'DisAgreeCat1': disagreeCat1.toString(),
      'StronglyDisAgreeCat1': stronglyDisagreeCat1.toString(),
    };
  }
}
