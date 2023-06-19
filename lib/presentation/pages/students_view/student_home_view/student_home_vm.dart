

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/models/stduent_model.dart';
import '../../../../data/models/teacher_model.dart';
import '../../../../locator.dart';

class StudentHomeViewModel extends ChangeNotifier{
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<TeacherModel>>? allTeachers;
  final teacherCollection = _db.collection('teachers');
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  StudentModel? student;
  String studentName = '';
  String studentImage = '';
  String studentEmail = '';


  set setStudentName(var newVal){
    studentName = newVal;
    notifyListeners();
  }

  set setStudentImage(var newVal){
    studentImage = newVal;
    notifyListeners();
  }



   getTeachers() {
    try {
      allTeachers = teacherCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => TeacherModel.fromJson(doc.data())).toList());
    } catch (e) {
      debugPrint('Exception in Get Tours $e');
      rethrow;
    }
  }

  getValueDataFromFireBase() async {

    try {
      var data =  await FirebaseFirestore.instance.collection('students').doc(_localStorageService.getEmail).get();
      student = StudentModel.fromSnapshot(data);
      if(student != null){
        setStudentName = student!.studentName.toString();
        setStudentImage = student!.imageUrl.toString();
        _localStorageService.setStudentName = student!.studentName.toString();
        _localStorageService.setStudentImage = student!.imageUrl.toString();
        String? token = await FirebaseMessaging.instance.getToken();
        print('Token is $token');
        await FirebaseFirestore.instance.collection('students').doc(_localStorageService.getEmail).set({'fcmToken': token},SetOptions(merge: true));

      }

    } on FirebaseException catch (e) {
      debugPrint("Exception in Fav $e");
      rethrow;
    }

  }

}