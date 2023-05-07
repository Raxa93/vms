import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  String studentName = '';
  String startTime = '';
  String endTime = '';
  String semester = '';
  String meetingWith = '';

  MeetingModel(
      {required this.studentName,
      required this.startTime,
      required this.endTime,
      required this.semester,
      required this.meetingWith
      });

  factory MeetingModel.fromSnapShot(DocumentSnapshot docSnap) {
    return MeetingModel(
        studentName: docSnap.get('studentName'),
        startTime: docSnap.get('semester'),
        endTime: docSnap.get('startTime'),
        semester: docSnap.get('endTime'),
    meetingWith: docSnap.get('meetingWith')
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'semester': semester,
      'startTime': startTime,
      'endTime': endTime,
      'meetingWith' : meetingWith
    };
  }
}
