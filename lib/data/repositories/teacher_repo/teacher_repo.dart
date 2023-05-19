

import 'dart:io';

import 'package:fu_vms/data/base/base_repo.dart';

abstract class TeacherRepo extends BaseRepo{


  Future saveTeacherData(String phoneNumber,String teacherName,File teacherImage,String userEmail);
  Future saveMeetings(meeting);

}