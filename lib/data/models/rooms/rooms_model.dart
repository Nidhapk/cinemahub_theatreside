class RoomModel {
  String userId;
  String roomId;
  String roomName;
  int? rows;
  int? columns;
  List<String>? seatStates;
  int? totalSeats;

  RoomModel({required this.roomId,
    required this.userId,
    required this.roomName,
    this.rows,
    this.columns,
    this.seatStates,
    this.totalSeats,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(roomId: json['roomId']?? '',
      userId: json['userId']?? '',
      roomName: json['roomName']?? '',
      rows: json['rows']?? 0,
      columns: json['columns']??0,
      seatStates: List<String>.from(json['seatDetails'] ?? []),
      totalSeats: json['totalSeats']?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'roomId':roomId,
      'userId': userId ,
      'roomName': roomName,
      'rows': rows ?? 0,
      'columns': columns?? 0,
      'seatDetails': seatStates?? [],
      'totalSeats': totalSeats?? 0,
    };
  }
}
