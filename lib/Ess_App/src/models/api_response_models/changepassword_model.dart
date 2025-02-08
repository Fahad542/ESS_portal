class PasswordChangeModel {
  final String status;
  final String statusMessage;

  PasswordChangeModel({
    required this.status,
    required this.statusMessage,
  });

  factory PasswordChangeModel.fromJson(Map<String, dynamic> json) {
    return PasswordChangeModel(
      status: json['status'],
      statusMessage: json['status_message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    return data;
  }
}
