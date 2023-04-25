// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import '../../../data/base/base_vm.dart';
import '../../../data/repositories/auth_repo/auth_repo.dart';
import '../../utils/validators.dart';

class LoginViewModel extends BaseVm {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;
  bool _isTeacher = false;

  final repo = GetIt.instance.get<AuthRepo>();

  // Getters
  bool get isHidden => _isHidden;
  bool get isTeacher => _isTeacher;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  // Setters
  set setIsHidden(bool val) {
    debugPrint('value i will set $val');
    _isHidden = val;
    notifyListeners();
  }

  Future<String?> loginWithEmailAndPassword(BuildContext context) async {
    EasyLoading.show();
    debugPrint(
        'This credentials ${emailController.text} and ${passwordController.text}');
    var value = await repo.signInWithEmailAndPassword(
        emailController.text, passwordController.text, context);
    if(value !=null){
      var userRole = await repo.checkUserRole(emailController.text);
      _isTeacher = userRole.isTeacher;
    }
    EasyLoading.dismiss();
    return value;
  }

  Future<String?> loginWithGoogle({required BuildContext context}) async {
    EasyLoading.show();
    var email = await repo.signInWithGoogle(context).whenComplete(() {
      EasyLoading.dismiss();
    });
    if (email != null) {
     var userRole = await repo.checkUserRole(email);
    _isTeacher = userRole.isTeacher;
    }
    return email;
  }

  Future resetPassword() async {
    return await repo.resetPassword(_emailController.text);
  }
}
