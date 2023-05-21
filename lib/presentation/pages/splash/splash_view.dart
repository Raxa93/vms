
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard_views/teacher_dashboard.dart';

import '../../../data/datasources/local/preferences_service.dart';
import '../../../locator.dart';
import '../login/login_view.dart';
import '../students_view/student_data_entry/student_data_entry_view.dart';
import '../teacher_views/data_entry_view/teacher_data_entry_view.dart';

class SplashView extends StatefulWidget {
  static const routeName = 'splash_view';
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initFirebaseMessaging();
      _initLocalNotifications();
      readValueAndNavigate();

    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }

  void readValueAndNavigate() {
    if (_localStorageService.getIsLoggedIn == true && _localStorageService.getIsTeacher){
      if(_localStorageService.getIsTeacherDataSaved == true){
        Navigator.pushReplacementNamed(context, TeacherDashBoardScreen.routeName);
      }
      else{
        Navigator.pushReplacementNamed(context, TeacherDataEntryView.routeName);
      }

    }
    else if(_localStorageService.getIsLoggedIn == true && _localStorageService.getIsTeacher == false){
      if(_localStorageService.getIsStudentDataSaved == true){
        Navigator.pushReplacementNamed(context, StudentHomeView.routeName);
      }
      else{
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const StudentDataEntryView()));
      }
      // Navigator.pushReplacementNamed(context, StudentHomeView.routeName);
    }
      else if(_localStorageService.getIsLoggedIn == false){
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    }
  }

  void _initFirebaseMessaging() async {
    print('Let me initailize firebase notifications');
    NotificationSettings settings =  await FirebaseMessaging.instance.requestPermission();

    // Configure notification handling
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   // Handle foreground notifications
    //   print('Received a notification message!');
    //   print('Foreground notification: $message');
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification when app is in background and opened from the notification
      print('Background notification: $message');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a notification message! ${message.notification?.body.toString()}');
      if (message.notification != null) {
        String title = message.notification!.title ?? 'Notification';
        String body = message.notification!.body ?? '';
        _showLocalNotification(title, body);
      }
    });
  }

  void _initLocalNotifications() {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showLocalNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'my_channel_01',
      'vms_channel',
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.green,
      enableLights: true,
      playSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }
}
