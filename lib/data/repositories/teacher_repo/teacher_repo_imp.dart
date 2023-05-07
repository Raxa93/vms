
import 'package:fu_vms/data/repositories/teacher_repo/teacher_repo.dart';

class TeacherRepoImp extends TeacherRepo{
  @override
  Future saveTeacherData(data,String userEmail) async {

    await teacherDbService.saveTeacherInformation(data,userEmail).then((value) {

      return value;
  });
  }

  @override
  Future saveMeetings(meeting)async {
    await teacherDbService.saveMeetingData(meeting);
  }

}