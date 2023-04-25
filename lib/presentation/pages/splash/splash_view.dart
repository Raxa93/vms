
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_view.dart';

import '../../../data/datasources/local/preferences_service.dart';
import '../../../locator.dart';
import '../login/login_view.dart';
import '../teacher_views/data_entry_view/teacher_data_entry_view.dart';

class SplashView extends StatefulWidget {
  static const routeName = 'splash_view';
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readValueAndNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }

  void readValueAndNavigate() {
    if (_localStorageService.getIsLoggedIn == true && _localStorageService.getIsTeacher) {
      Navigator.pushReplacementNamed(context, TeacherDataEntryView.routeName);
    }
    else if(_localStorageService.getIsLoggedIn == true && _localStorageService.getIsTeacher == false){
      Navigator.pushReplacementNamed(context, StudentHomeView.routeName);
    }
      else if(_localStorageService.getIsLoggedIn == false){
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    }
  }
}
