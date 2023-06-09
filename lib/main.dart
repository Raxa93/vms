import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/presentation/pages/brewery/brewery_vm.dart';
import 'package:fu_vms/presentation/pages/login/login_vm.dart';
import 'package:fu_vms/presentation/pages/register/register_vm.dart';
import 'package:fu_vms/presentation/pages/splash/splash_view.dart';
import 'package:fu_vms/presentation/pages/students_view/student_appointment_booking_view/student_meeting_request_vm.dart';
import 'package:fu_vms/presentation/pages/students_view/student_data_entry/student_data_entry_vm.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_vm.dart';
import 'package:fu_vms/presentation/pages/teacher_views/data_entry_view/teacher_data_entry_vm.dart';
import 'package:fu_vms/presentation/pages/teacher_views/diary_view/diary_vm.dart';
import 'package:fu_vms/presentation/pages/teacher_views/meeting_view/new_meeting_vm.dart';
import 'package:fu_vms/presentation/pages/teacher_views/student_list_view/student_list_vm.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard_views/teacher_dashboard_vm.dart';
import 'package:fu_vms/presentation/pages/teacher_views/time_table_view/time_table_vm.dart';
import 'package:fu_vms/router.dart';
import 'package:provider/provider.dart';

import 'locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => BreweryVm()),
        ChangeNotifierProvider(create: (_) => TeacherDataEntryViewModel()),
        ChangeNotifierProvider(create: (_) => TeacherDashBoardVm()),
        ChangeNotifierProvider(create: (_) => DiaryViewModel()),
        ChangeNotifierProvider(create: (_) => TimeTableVm()),
        ChangeNotifierProvider(create: (_) => NewMeetingVm()),
        ChangeNotifierProvider(create: (_) => StudentDataEntryViewModel()),
        ChangeNotifierProvider(create: (_) => StudentHomeViewModel()),
        ChangeNotifierProvider(create: (_) => MeetingRequestVm()),
        ChangeNotifierProvider(create: (_) => StudentListVm()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashView.routeName,
        // initialRoute: BreweryMainView.routeName,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.green,
            secondary: Colors.grey,
          ),

        ),
        builder: EasyLoading.init(),
        onGenerateRoute: (settings) => generateRoute(settings),
      ),
    );
  }
}
