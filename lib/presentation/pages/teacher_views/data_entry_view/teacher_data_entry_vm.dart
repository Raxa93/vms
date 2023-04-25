import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/data/datasources/remote/teacher_db_service.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/repositories/teacher_repo/teacher_repo_imp.dart';
import '../../../../locator.dart';
import '../../../utils/i_utills.dart';
import '../../../utils/validators.dart';
import '../teacher_dashboard.dart';

class TeacherDataEntryViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final teacherFireStoreRepo = GetIt.instance.get<TeacherRepoImp>();

  String? Function(String? password) get passwordValidator =>
      Validator.nameValidator;

  Future saveTeacherData(context) async {
    EasyLoading.show();
    String? token = await FirebaseMessaging.instance.getToken();
    var data = {
      'teacherName': nameController.text,
      'phoneNumber': phoneController.text,
      'fcmToken': token
    };
    teacherFireStoreRepo.saveTeacherData(data).then((value) {


        _localStorageService.setIsTeacherDataSaved = true;
        iUtills().showMessage(
            context: context, title: 'Success', text: 'Data Saved');
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacementNamed(
            TeacherDashBoardScreen.routeName);


    });
  }
}
