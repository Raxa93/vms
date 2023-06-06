
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRoleModel{
  String userId = '';
  bool isTeacher = false;
  bool isDataSaved = false;

  UserRoleModel({required this.userId,required this.isTeacher,required this.isDataSaved});

  factory UserRoleModel.fromSnapShot(DocumentSnapshot snapShot) {

return UserRoleModel(
    userId: snapShot.get('uid'),
    isTeacher: snapShot.get('isTeacher'),
  isDataSaved: snapShot.get('isDataSaved')

);


  }

}