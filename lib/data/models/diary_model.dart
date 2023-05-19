import 'dart:developer';


class TeacherNote {
  final String title;
  final String description;
  final String timestamp;

  TeacherNote({

    required this.title,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp,
    };
  }

  factory TeacherNote.fromMap(Map<String, dynamic> map) {
    log('i got some data ${map['title']}');
    log('i got some data ${map['description']}');
    log('i got some data ${map['timestamp']}');
    return TeacherNote(
      title: map['title'],
      description: map['description'],
      timestamp: map['timestamp'],
    );
  }
}