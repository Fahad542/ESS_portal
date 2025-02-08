class Reservations {
  List<ReservationDatalist>? datalist;

  Reservations({this.datalist});

  Reservations.fromJson(Map<String, dynamic> json) {
    if (json['Datalist'] != null) {
      datalist = <ReservationDatalist>[];
      json['Datalist'].forEach((v) {
        datalist!.add(new ReservationDatalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datalist != null) {
      data['Datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReservationDatalist {
  String? id;
  String? boardRoom;
  String? reserveTime;
  String? reserveDate;
  String? bookBy;
  String? remarks;
  String? noOfPeople;
  String? agenda;
  String? eventStatus;

  ReservationDatalist
      (
      {this.id,
        this.boardRoom,
        this.reserveTime,
        this.reserveDate,
        this.bookBy,
        this.remarks,
        this.noOfPeople,
        this.agenda,
        this.eventStatus
      }
      );

  ReservationDatalist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardRoom = json['board_room'];
    reserveTime = json['reserve_time'];
    reserveDate = json['reserve_date'];
    bookBy = json['book_by'];
    remarks = json['remarks'];
    noOfPeople = json['no_of_people'];
    agenda = json['agenda'];
    eventStatus = json['event_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['board_room'] = this.boardRoom;
    data['reserve_time'] = this.reserveTime;
    data['reserve_date'] = this.reserveDate;
    data['book_by'] = this.bookBy;
    data['remarks'] = this.remarks;
    data['no_of_people'] = this.noOfPeople;
    data['agenda'] = this.agenda;
    data['event_status'] = this.eventStatus;
    return data;
  }
}