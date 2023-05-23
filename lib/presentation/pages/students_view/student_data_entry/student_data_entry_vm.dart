

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_view.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/repositories/teacher_repo/teacher_repo_imp.dart';
import '../../../../locator.dart';
import '../../../utils/i_utills.dart';
import '../../../utils/validators.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StudentDataEntryViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController sessionController = TextEditingController();
  File? imageFile;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final usersCollection = _db.collection('users');
  final studentCollection = _db.collection('students');

  void setImageFile(File file) {
    imageFile = file;
    notifyListeners();
  }

  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  final teacherFireStoreRepo = GetIt.instance.get<TeacherRepoImp>();
  String? Function(String? password) get passwordValidator => Validator.nameValidator;

  Future saveStudentData(context) async {
    EasyLoading.show();
    String userEmail = _localStorageService.getEmail;
    print('This is user email i got ${userEmail}');
    final String base64File = base64Encode(await imageFile!.readAsBytes());
    _localStorageService.setStudentImage = base64File;
    try{
      String? token = await FirebaseMessaging.instance.getToken();
      final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref().child('images').child(userEmail); // Replace 'email' with the teacher's email or a unique identifier
      final firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile!);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      final imageUrl = await taskSnapshot.ref.getDownloadURL();
      var data = {
        'studentName': nameController.text,
        'phoneNumber': phoneController.text,
        'fcmToken': token,
        'imageUrl': imageUrl,
        'semester' : semesterController.text,
        'session' : sessionController.text,
        'section' : sectionController.text,
        'shift': shiftController.text,
      };
      await studentCollection.doc(userEmail).set(data,SetOptions(merge: true)).then((value) {
        _localStorageService.setIsStudentDataSaved = true;
        _localStorageService.setStudentName = nameController.text;
        iUtills().showMessage(context: context, title: 'Success', text: 'Data Saved');
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacementNamed(StudentHomeView.routeName);
      });}

    catch(e){
      iUtills().showMessage(context: context, title: 'OOpsss', text: 'Something went wrong');
      EasyLoading.dismiss();
      debugPrint('Exception while saving teacher data $e');
    }

  }

}
