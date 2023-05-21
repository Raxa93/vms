

class TimeTableModel {
  final String teacherEmail;
  final String section;
  final String semester;
  final String room;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;

  TimeTableModel({
    required this.teacherEmail,
    required this.section,
    required this.semester,
    required this.room,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) {
    return TimeTableModel(
      teacherEmail: json['teacherEmail'],
      section: json['section'],
      semester: json['semester'],
      room: json['room'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherEmail': teacherEmail,
      'section': section,
      'semester': semester,
      'room': room,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
