import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting {
  late String title;
  late String description;
  late String venue;
  late String startDateTime;
  late String endDateTime;
  late bool approved;
  late bool inProgress;


  Meeting({
    required this.title,
    required this.description,
    required this.venue,
    required this.startDateTime,
    required this.endDateTime,
    required this.approved,
    required this.inProgress,

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

    );
  }
}

