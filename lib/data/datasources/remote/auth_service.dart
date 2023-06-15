// ignore_for_file: await_only_futures, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../errors/error_codes.dart';
import '../../../presentation/utils/i_utills.dart';

class AuthService {
  AuthService() {
    init();
  }

  final auth = FirebaseAuth.instance;
  User? _user;
  late GoogleSignIn _googleSignIn;

  init() {
    _googleSignIn = GoogleSignIn();
  }

  Future<String?> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((value) async {
        _user = auth.currentUser;
      });
      await Future.delayed(Duration.zero);
      if(_user != null){
        return  _user!.email;
      }

    } on FirebaseAuthException catch (e) {
      print('Error while login ${e.toString()}');
      iUtills().showMessage(
          context: context, title: 'Something went Wrong', text: e.code);
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occurred!';

    } catch (e) {
      iUtills().showMessage(
          context: context, title: 'Something went Wrong', text: e.toString());
      throw '${e.toString()} Error Occurred!';
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      _user = result.user;
      debugPrint('This is value of user ${_user?.email}');
      return  _user?.email;
    }  catch (e) {
      debugPrint(e.toString());

    }
  }

  Future signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      _user = result.user;
      return await _user?.email;
    } on FirebaseAuthException catch (e) {
      debugPrint(signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occurred!');
      iUtills().showMessage(
          context: context, title: 'Something went Wrong', text: e.code);
    } catch (e) {
      debugPrint('${e.toString()} Error Occurred!');
    }
  }

  Future sendVerificationEmail() async {
    try {
      _user = auth.currentUser;
      _user!.sendEmailVerification();
    } catch (e) {
      debugPrint('${e.toString()} Error Occurred!');
    }
  }

  Future checkEmailVerification() async {
     await FirebaseAuth.instance.currentUser?.reload();
     final user = FirebaseAuth.instance.currentUser;
     bool emailVerified = user!.emailVerified;

    if (emailVerified) {
      debugPrint('I will return true');
      return true;
    } else {
     await deleteUser();
     debugPrint('I will return false');
      return false;
    }
  }

  Future deleteUser() async {
   await auth.currentUser!.delete();
    await FirebaseAuth.instance.signOut();
  }

  Future resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
