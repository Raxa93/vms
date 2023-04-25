import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import '../../../data/base/base_vm.dart';
import '../../../data/repositories/auth_repo/auth_repo.dart';
import '../../utils/validators.dart';

class RegisterViewModel extends BaseVm {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isHidden = true;
  final repo = GetIt.instance.get<AuthRepo>();

  // Getters
  bool get isHidden => _isHidden;



  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;


  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? confirmPassword) get confirmPasswordValidator =>
      (confirmPassword) {
        return Validator.confirmPasswordValidator(
            confirmPassword, passwordController.text.trim());
      };

  // Setters
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }


  void onModelDestroy() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future register() async {
    EasyLoading.show();
    var res = await repo.registerUser(
      _emailController.text.trim(),
      _passwordController.text,
    );
    EasyLoading.dismiss();
    return res;
  }

  Future sendLinkToEmail() async {
    await repo.sendVerifyEmail();
  }

  Future checkEmailVerification() async {
    return await repo.checkEmailIsVerified();
  }  
  


}
