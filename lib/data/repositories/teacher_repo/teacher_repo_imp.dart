
import 'dart:io';

import 'package:fu_vms/data/repositories/teacher_repo/teacher_repo.dart';

class TeacherRepoImp extends TeacherRepo{
  @override
  Future saveTeacherData(String phoneNumber,String teacherName,File teacherImage,String userEmail) async {

    await teacherDbService.saveTeacherInformation(phoneNumber,teacherName,teacherImage,userEmail).then((value) {

      return value;
  });
  }

  @override
  Future saveMeetings(meeting)async {
    await teacherDbService.saveMeetingData(meeting);
  }

}