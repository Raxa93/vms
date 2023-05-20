import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting {
  late String title;
  late String description;
  late String venue;
  late String startDateTime;
  late String endDateTime;
  late String startTime;
  late String endTime;
  late bool approved;
  late bool inProgress;
  late String requestedFrom;


  Meeting({
    required this.title,
    required this.description,
    required this.venue,
    required this.startDateTime,
    required this.endDateTime,
    required this.startTime,
    required this.endTime,
    required this.approved,
    required this.inProgress,
    required this.requestedFrom,

  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'venue': venue,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'approved': approved,
      'inProgress': inProgress,
      'requestedFrom': requestedFrom,
      'startTime': startTime,
      'endTime': endTime,

    };
  }

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      title: json['title'],
      description: json['description'],
      venue: json['venue'],
      startDateTime: json['startDateTime'],
      endDateTime: json['endDateTime'],
      approved: json['approved'],
      inProgress: json['inProgress'],
      requestedFrom: json['requestedFrom'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}

