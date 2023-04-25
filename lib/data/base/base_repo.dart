

import 'package:fu_vms/data/datasources/local/preferences_service.dart';
import 'package:fu_vms/data/datasources/remote/teacher_db_service.dart';

import '../datasources/remote/api_service.dart';
import '../datasources/remote/auth_service.dart';

abstract class BaseRepo{


  AuthService authService = AuthService();
  ApiService apiService = ApiService();
  TeacherDbServices teacherDbService = TeacherDbServices();
  LocalStorageService localStorageService = LocalStorageService();

}