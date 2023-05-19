
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService{


  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;
  static const String isLoggedInKey = 'is_logged_in_key';
  static const String emailKey = 'email_key';
  static const String isTeacher = 'is_teacher_key';
  static const String isTeacherDataSaved = 'is_teacher_data_saved_key';
  static const String teacherNameKey = 'teacher_name_key';
  static const String teacherImageKey = 'teacher_image_key';


  bool get getIsLoggedIn => _getFromDisk(isLoggedInKey) ?? false;
  String get getEmail => _getFromDisk(emailKey) ?? '';
  bool get getIsTeacher => _getFromDisk(isTeacher) ?? false;
  bool get getIsTeacherDataSaved => _getFromDisk(isTeacherDataSaved) ?? false;
  String get getTeacherName => _getFromDisk(teacherNameKey) ?? '';
  String get getTeacherImage => _getFromDisk(teacherImageKey) ?? '';

  set setIsLoggedIn(bool val) {
    _saveToDisk(isLoggedInKey, val);
  }

  set setUserEmail(String val) {
    _saveToDisk(emailKey, val);
  }

  set setIsTeacher(bool val) {
    _saveToDisk(isTeacher, val);
  }
  set setIsTeacherDataSaved(bool val) {
    _saveToDisk(isTeacherDataSaved, val);
  }

  set setTeacherName(String val) {
    _saveToDisk(teacherNameKey, val);
  }

  set setTeacherImage(var val) {
    _saveToDisk(teacherImageKey, val);
  }

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }


  dynamic _getFromDisk(String key) {

    final value = _preferences.get(key);
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }


}