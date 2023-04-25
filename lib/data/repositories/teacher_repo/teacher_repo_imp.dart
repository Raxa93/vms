
import 'package:fu_vms/data/repositories/teacher_repo/teacher_repo.dart';

class TeacherRepoImp extends TeacherRepo{
  @override
  Future saveTeacherData(data) async {

    await teacherDbService.saveTeacherInformation(data).then((value) {

      return value;
  });
  }

}