
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fu_vms/data/models/meeting_data_model.dart';
import 'package:fu_vms/data/models/user_role_model.dart';

class TeacherDbServices{
  static late TeacherDbServices _instance;
  static Future<TeacherDbServices> getInstance() async {
    _instance = TeacherDbServices();
    return _instance;
  }

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final usersCollection = _db.collection('users');
  final teacherCollection = _db.collection('teachers');
  final meetingCollection = _db.collection('meetings');


  Future<UserRoleModel> checkUserRole(String email)async {

    User? user = FirebaseAuth.instance.currentUser;
    if(user !=null){

      try {
        DocumentSnapshot snapshot = await usersCollection.doc(email).get();
        if(snapshot.exists){
          return UserRoleModel.fromSnapShot(await usersCollection.doc(email).get());
        }
        else{
          await usersCollection.doc(email).set({
            'isTeacher': false,
            'uid': user.uid,
          });
        }
        await Future.delayed(const Duration(seconds: 1));
      } catch (e) {
        debugPrint('Exception in checking user role $e');
        rethrow;
      }
    }
    return UserRoleModel.fromSnapShot(await usersCollection.doc(email).get());
  }

  Future saveTeacherInformation(data,String userEmail) async {
    try{
      // User? user = FirebaseAuth.instance.currentUser;

      await teacherCollection.doc(userEmail).set(data);}

    catch(e){
      debugPrint('Exception while saving teacher data $e');
    }

  }

  Future saveMeetingData( meetings) async {
    await meetingCollection.doc('razaahmad93@gmail.com').set(meetings);
  }


}