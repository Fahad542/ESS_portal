class PollResponse {
  final String code;
  final String msg;
  final List<User> pool;

  PollResponse({
    required this.code,
    required this.msg,
    required this.pool,
  });

  factory PollResponse.fromJson(Map<String, dynamic> json) {
    var poolList = json['Pool'] as List;
    List<User> pool = poolList.map((i) => User.fromJson(i)).toList();

    return PollResponse(
      code: json['code'],
      msg: json['Msg'],
      pool: pool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'Msg': msg,
      'Pool': pool.map((u) => u.toJson()).toList(),
    };
  }
}

class User {
  final String empCode;
  final String username;

  User({
    required this.empCode,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      empCode: json['emp_code'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emp_code': empCode,
      'username': username,
    };
  }
}
