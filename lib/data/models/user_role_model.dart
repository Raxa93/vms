
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRoleModel{
  String userId = '';
  bool isTeacher = false;

  UserRoleModel({required this.userId,required this.isTeacher});

  factory UserRoleModel.fromSnapShot(DocumentSnapshot snapShot) {

return UserRoleModel(
    userId: snapShot.get('uid'),
    isTeacher: snapShot.get('isTeacher'));


  }

}