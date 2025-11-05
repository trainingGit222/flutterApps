class ModelTimedate {
  String? date;
  String? time;
  ModelTimedate({this.date, this.time});
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['time'] = time;
    return map;
  }
  factory ModelTimedate.fromMap(Map<String, dynamic> map) {
    return ModelTimedate(
      date: map['date'],
      time: map['time'],
    );
  }
}