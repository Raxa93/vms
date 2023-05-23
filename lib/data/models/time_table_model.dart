

class TimeTableModel {
  final String teacherEmail;
  final String section;
  final String semester;
  final String room;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String subject;

  TimeTableModel({
    required this.teacherEmail,
    required this.section,
    required this.semester,
    required this.room,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.subject,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) {
    return TimeTableModel(
      teacherEmail: json['teacherEmail'] ?? 'Not Added',
      section: json['section'] ?? 'Not Added',
      semester: json['semester'] ?? 'Not Added',
      room: json['room'] ?? 'Not Added',
      startDate: json['startDate'] ?? 'Not Added',
      endDate: json['endDate'] ?? 'Not Added',
      startTime: json['startTime'] ?? 'Not Added',
      endTime: json['endTime'] ?? 'Not Added' ,
      subject: json['subject'] ?? 'Not Added',
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
      'subject': subject,
    };
  }
}
