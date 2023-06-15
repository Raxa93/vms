

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fu_vms/data/models/stduent_model.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../locator.dart';

class StudentListVm extends ChangeNotifier{

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<StudentModel>>? allStudents;
  final studentCollection = _db.collection('students');
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  String teacherName = '';
  String teacherEmail = '';
  String teacherImage = '';

  getStudents() {
    try {
      allStudents = studentCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => StudentModel.fromJson(doc.data())).toList());
    } catch (e) {
      debugPrint('Exception in Get Tours $e');
      rethrow;
    }
  }

  getValueFromDisk(){
    teacherName = _localStorageService.getTeacherName;
    teacherEmail = _localStorageService.getEmail;
    teacherImage = _localStorageService.getTeacherImage;
  }

}