

import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel{

  String studentName;
  String phoneNumber;
  String imageUrl;
  String semester;
  String session;
  String section;
  String shift;
  String token;

  StudentModel({required this.studentName,required this.token,required this.phoneNumber,required this.imageUrl,required this.semester,required this.session,required this.section,required this.shift});


  factory StudentModel.fromJson(Map<String, dynamic> json) {
    // print('I got data ${json['studentName']}');
    // print('I got data ${json['section']}');
    return StudentModel(
      studentName: json['studentName'],
      section: json['section'],
      semester: json['semester'],
      shift: json['shift'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      session: json['session'],
      token: json['fcmToken']
    );
  }

  factory StudentModel.fromSnapshot(DocumentSnapshot docSnapshot) {
    // print('Brother i got agency name ${docSnapshot.get('agencyName')}');


    return StudentModel(
      studentName: docSnapshot.get('studentName'),
      phoneNumber: docSnapshot.get('phoneNumber'),
      imageUrl: docSnapshot.get('imageUrl'),
      token: docSnapshot.get('fcmToken'),
      section: docSnapshot.get('section'),
      semester: docSnapshot.get('semester'),
      shift: docSnapshot.get('shift'),
        session: docSnapshot.get('session'),

    );
  }
}