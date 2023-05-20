

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/models/teacher_model.dart';

class StudentHomeViewModel extends ChangeNotifier{
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<TeacherModel>>? allTeachers;
  final teacherCollection = _db.collection('teachers');



   getTeachers() {
    try {
      allTeachers = teacherCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => TeacherModel.fromJson(doc.data())).toList());
    } catch (e) {
      debugPrint('Exception in Get Tours $e');
      rethrow;
    }
  }



}