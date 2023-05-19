
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fu_vms/data/models/user_role_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  Future saveTeacherInformation(String phoneNumber,String teacherName,File teacherImage,String userEmail) async {
    try{
      String? token = await FirebaseMessaging.instance.getToken();
      final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref().child('images').child(userEmail); // Replace 'email' with the teacher's email or a unique identifier
      final firebase_storage.UploadTask uploadTask = storageRef.putFile(teacherImage);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      final imageUrl = await taskSnapshot.ref.getDownloadURL();
      var data = {
        'teacherName': teacherName,
        'phoneNumber': phoneNumber,
        'fcmToken': token,
        'imageUrl': imageUrl,
      };
      await teacherCollection.doc(userEmail).update(data);}

    catch(e){
      debugPrint('Exception while saving teacher data $e');
    }

  }

  Future saveMeetingData( meetings) async {
    await meetingCollection.doc('razaahmad93@gmail.com').set(meetings);
  }


}