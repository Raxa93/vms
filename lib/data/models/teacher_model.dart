
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fu_vms/data/models/time_table_model.dart';

class TeacherModel {
  String teacherName;
  String phoneNumber;
  String token;
  String imageUrl;
  List<TimeTableModel> teacherTimeTable = [];

  TeacherModel(
      {required this.teacherName,
      required this.phoneNumber,
      required this.token,
      required this.imageUrl,
      required this.teacherTimeTable});

  Map<String, dynamic> toJson() {
    return {
      'teacherName': teacherName,
      'phoneNumber': phoneNumber,
      'fcmToken': token,
      'imageUrl': imageUrl,
      'timeTable': teacherTimeTable
    };
  }

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> timeTableJson = json['timeTable'] ?? [];
    List<TimeTableModel> teacherTimeTable = [];

    for (var item in timeTableJson) {
      // Process each item and add it to teacherTimeTable list
      // Adjust this code according to the structure of each item in the 'timeTable' list
      // For example, if the items in the list have a 'name' field, you can access it like item['name']
      teacherTimeTable.add(TimeTableModel.fromJson(item));
    }

    return TeacherModel(
      teacherName: json['teacherName'] ?? 'Not Added',
      phoneNumber: json['phoneNumber'] ?? 'Not Added',
      imageUrl: json['imageUrl'] ?? 'Not Added',
      token: json['fcmToken'] ?? 'Not Added',
      teacherTimeTable: teacherTimeTable,
    );
  }

  factory TeacherModel.fromSnapshot(DocumentSnapshot docSnapshot) {
    // print('Brother i got agency name ${docSnapshot.get('agencyName')}');
    List<dynamic> timeTableJson = docSnapshot.get('timeTable');
    List<TimeTableModel> teacherTimeTable = [];

    for (var item in timeTableJson) {
      // Process each item and add it to teacherTimeTable list
      // Adjust this code according to the structure of each item in the 'timeTable' list
      // For example, if the items in the list have a 'name' field, you can access it like item['name']
      teacherTimeTable.add(TimeTableModel.fromJson(item));
    }
    return TeacherModel(
      teacherName: docSnapshot.get('teacherName'),
      phoneNumber: docSnapshot.get('phoneNumber'),
      imageUrl: docSnapshot.get('imageUrl'),
      token: docSnapshot.get('fcmToken'),
      teacherTimeTable: teacherTimeTable,

    );
  }

}
