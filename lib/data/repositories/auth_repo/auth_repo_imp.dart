import 'package:flutter/material.dart';

import '../../models/user_role_model.dart';
import 'auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  @override
  Future<String?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    return await authService.signInWithEmailAndPassword(
        email, password, context);
  }

  @override
  Future<String?> registerUser(String email, String password) async {
    return await authService.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<String?> signInWithGoogle(BuildContext context) async {
    return await authService.signInWithGoogle(context);
  }

  @override
  Future sendVerifyEmail() async {
    return await authService.sendVerificationEmail();
  }

  @override
  Future checkEmailIsVerified() async {
    return await authService.checkEmailVerification();
  }

  @override
  Future resetPassword(String email) async {
    return await authService.resetPassword(email);
  }

  @override
  Future<UserRoleModel> checkUserRole(String email)async {

    return await teacherDbService.checkUserRole(email);
  }
}
