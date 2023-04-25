

import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/brewery/brewery_main.dart';
import 'package:fu_vms/presentation/pages/brewery/brewr_detail.dart';
import 'package:fu_vms/presentation/pages/login/forget_password_view.dart';
import 'package:fu_vms/presentation/pages/login/login_view.dart';
import 'package:fu_vms/presentation/pages/register/register_view.dart';
import 'package:fu_vms/presentation/pages/register/verification_view.dart';
import 'package:fu_vms/presentation/pages/splash/splash_view.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/data_entry_view/teacher_data_entry_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard.dart';

import 'data/models/brewry_model.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name)
  {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) =>  const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) =>  LoginView());
    case RegisterView.routeName:
      return MaterialPageRoute(builder: (context) =>  RegisterView());
    case VerificationView.routeName:
      return MaterialPageRoute(builder: (context) =>  VerificationView(email: settings.arguments as String,));
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (context) =>  ForgetPasswordView());
      case TeacherDataEntryView.routeName:
      return MaterialPageRoute(builder: (context) =>  const TeacherDataEntryView());
      case TeacherDashBoardScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  const TeacherDashBoardScreen());
      case StudentHomeView.routeName:
      return MaterialPageRoute(builder: (context) =>  const StudentHomeView());


    case BreweryMainView.routeName:
      return MaterialPageRoute(builder: (context) =>  const BreweryMainView());
    case BreweryDetailView.routeName:
      return MaterialPageRoute(builder: (context) =>  BreweryDetailView(brewerModel: settings.arguments as BreweryModel));

    default:
      return errorRoute();
  }
}

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('OOOpsss!'),
        ),
        body: const Center(
          child: Text('Oh No! You should not be here! '),
        ),
      );
    },
  );
}
