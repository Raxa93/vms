

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fu_vms/data/models/stduent_model.dart';

class StudentListVm extends ChangeNotifier{

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<StudentModel>>? allStudents;
  final studentCollection = _db.collection('students');



  getStudents() {
    try {
      allStudents = studentCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => StudentModel.fromJson(doc.data())).toList());
    } catch (e) {
      debugPrint('Exception in Get Tours $e');
      rethrow;
    }
  }



}