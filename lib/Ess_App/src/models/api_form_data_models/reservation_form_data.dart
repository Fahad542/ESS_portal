class ReservationFormData {
  String? boardRoom;
  String? bookDate;
  String? fromTime;
  String? toTime;
  String? remarks;
  String? nop;
  String? agenda;
  String? empCode;

  ReservationFormData(
      {this.boardRoom,
        this.bookDate,
        this.fromTime,
        this.toTime,
        this.remarks,
        this.nop,
        this.agenda,
        this.empCode});

  ReservationFormData.fromJson(Map<String, dynamic> json) {
    boardRoom = json['board_room'];
    bookDate = json['book_date'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    remarks = json['remarks'];
    nop = json['nop'];
    agenda = json['agenda'];
    empCode = json['emp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['board_room'] = this.boardRoom;
    data['book_date'] = this.bookDate;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['remarks'] = this.remarks;
    data['nop'] = this.nop;
    data['agenda'] = this.agenda;
    data['emp_code'] = this.empCode;
    return data;
  }
}
