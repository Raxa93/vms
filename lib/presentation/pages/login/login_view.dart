// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard_views/teacher_dashboard.dart';
import 'package:provider/provider.dart';
import '../../../data/datasources/local/preferences_service.dart';
import '../../../locator.dart';
import '../../components/custom_text_field.dart';
import '../../configurations/size_config.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../register/register_view.dart';
import '../students_view/student_data_entry/student_data_entry_view.dart';
import '../teacher_views/data_entry_view/teacher_data_entry_view.dart';
import 'forget_password_view.dart';
import 'login_vm.dart';

class LoginView extends StatelessWidget {
  static const routeName = 'login_screen';
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<LoginViewModel>(
      builder: ((context, vm, child) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.07),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: AppStyle.headline1,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.06),
                        CustomTextField(
                          controller: vm.emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          prefix: Icons.email,
                          validator: vm.emailValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.03),
                        CustomTextField(
                          controller: vm.passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          prefix: Icons.lock,
                          isHidden: vm.isHidden,
                          validator: vm.passwordValidator,
                          suffix: IconButton(
                            icon: vm.isHidden
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              vm.setIsHidden = !vm.isHidden;
                            },
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.03),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: AppStyle.elevatedButtonStyle,
                                onPressed: () async =>
                                    _formKey.currentState!.validate()
                                        ? await vm.loginWithEmailAndPassword(context).then((value) async {
                                              debugPrint('Value in view $value');
                                            if (value != null) {
                                              EasyLoading.dismiss();
                                              _localStorageService.setIsLoggedIn = true;
                                              _localStorageService.setUserEmail = value;
                                              if(vm.isTeacher){
                                                String? token = await FirebaseMessaging.instance.getToken();
                                                await FirebaseFirestore.instance.collection('teachers').doc(value).set({'fcmToken': token},SetOptions(merge: true));
                                                _localStorageService.setIsTeacher = true;
                                               // bool isTeacherDataSaved = _localStorageService.getIsTeacherDataSaved;
                                               bool isTeacherDataSaved = vm.isDataSaved;
                                               if(isTeacherDataSaved){
                                                 _localStorageService.setIsTeacherDataSaved = true;
                                               }
                                               isTeacherDataSaved ?
                                                Navigator.of(context).pushReplacementNamed(TeacherDashBoardScreen.routeName) :
                                               Navigator.of(context).pushReplacementNamed(TeacherDataEntryView.routeName)
                                                ;
                                              }
                                              else{
                                                _localStorageService.setIsTeacher = false;

                                                // bool isStudentDataSaved = _localStorageService.getIsStudentDataSaved;
                                                bool isStudentDataSaved = vm.isDataSaved;
                                                String? token = await FirebaseMessaging.instance.getToken();
                                                await FirebaseFirestore.instance.collection('students').doc(value).set({'fcmToken': token},SetOptions(merge: true));
                                                if(isStudentDataSaved){
                                                  _localStorageService.setIsStudentDataSaved = true;
                                                }
                                                isStudentDataSaved ?
                                                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const StudentHomeView()))
                                                    :Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const StudentDataEntryView()));
                                              }
                                            }
                                          })
                                        : null,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Log In'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: AppStyle.elevatedButtonStyle,
                                onPressed: () async {
                                  var success = await vm.loginWithGoogle(context: context);
                                  if(success != null){
                                    _localStorageService.setIsLoggedIn = true;
                                    _localStorageService.setUserEmail = success;
                                    if(vm.isTeacher){
                                      _localStorageService.setIsTeacher = true;
                                      Navigator.of(context).pushReplacementNamed(TeacherDataEntryView.routeName);
                                    }
                                    else{
                                      _localStorageService.setIsTeacher = false;

                                      Navigator.of(context).pushReplacementNamed(StudentHomeView.routeName);
                                    }

                                  }
                                },

                                //      await vm.loginWithGoogle(context: context).then((value) {
                                //   debugPrint('Value in view $value');
                                //   if (value != 'null') {
                                //     EasyLoading.dismiss();
                                //     Navigator.of(context).pushReplacementNamed(HomeView.routeName);
                                //   }
                                // }),

                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Continue With Gmail'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.015),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(RegisterView.routeName);
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child:  Text(
                              "Don't have an account? Create one",
                              style: AppStyle.bodyText1.copyWith(
                                color: AppColors.primary
                              )
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ForgetPasswordView.routeName);
                            },
                            style: ButtonStyle(
                              overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text(
                              "Forget Password",
                              style: AppStyle.bodyText1
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
