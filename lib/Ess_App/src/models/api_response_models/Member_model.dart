class MembersList {
  List<Member> members;

  MembersList({required this.members});

  factory MembersList.fromJson(Map<String, dynamic> json) {
    var list = json['Members'] as List;
    List<Member> membersList = list.map((i) => Member.fromJson(i)).toList();

    return MembersList(members: membersList);
  }

  Map<String, dynamic> toJson() {
    return {
      'Members': members.map((member) => member.toJson()).toList(),
    };
  }
}

class Member {
  String memberCode;
  String memberName;
  String? memberEmail;
  String? memberPassword;
  String? memberDesignation;
  String? mobile;
  String? hod;
  String? dp;

  Member({
    required this.memberCode,
    required this.memberName,
    this.memberEmail,
    this.memberPassword,
    this.memberDesignation,
    this.mobile,
    this.hod,
    this.dp,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberCode: json['member_code'] ?? '',
      memberName: json['member_name'] ?? '',
      memberEmail: json['member_email'],
      memberPassword: json['member_password'],
      memberDesignation: json['member_designation'],
      mobile: json['mobile'],
      hod: json['hod'],
      dp: json['dp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_code': memberCode,
      'member_name': memberName,
      'member_email': memberEmail,
      'member_password': memberPassword,
      'member_designation': memberDesignation,
      'mobile': mobile,
      'hod': hod,
      'dp': dp,
    };
  }
}

