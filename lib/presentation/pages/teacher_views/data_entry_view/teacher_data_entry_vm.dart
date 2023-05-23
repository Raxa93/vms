import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/repositories/teacher_repo/teacher_repo_imp.dart';
import '../../../../locator.dart';
import '../../../utils/i_utills.dart';
import '../../../utils/validators.dart';
import '../teacher_dashboard_views/teacher_dashboard.dart';

class TeacherDataEntryViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
   File? imageFile;

  void setImageFile(File file) {
    imageFile = file;
    notifyListeners();
  }

  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  final teacherFireStoreRepo = GetIt.instance.get<TeacherRepoImp>();
  String? Function(String? password) get passwordValidator => Validator.nameValidator;

  Future saveTeacherData(context) async {
    EasyLoading.show();
    String userEmail = _localStorageService.getEmail;
    final String base64File = base64Encode(await imageFile!.readAsBytes());
     _localStorageService.setTeacherImage = base64File;
     teacherFireStoreRepo.saveTeacherData(phoneController.text,nameController.text,imageFile!,userEmail).then((value) {
        _localStorageService.setIsTeacherDataSaved = true;
        _localStorageService.setTeacherName = nameController.text;
        iUtills().showMessage(context: context, title: 'Success', text: 'Data Saved');
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacementNamed(TeacherDashBoardScreen.routeName);
    });
  }

}
