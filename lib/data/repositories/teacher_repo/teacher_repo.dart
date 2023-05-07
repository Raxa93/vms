

import 'package:fu_vms/data/base/base_repo.dart';

abstract class TeacherRepo extends BaseRepo{


  Future saveTeacherData(data,String userEmail);
  Future saveMeetings(meeting);

}