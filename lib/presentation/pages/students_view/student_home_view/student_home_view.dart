
import 'package:flutter/material.dart';

class StudentHomeView extends StatefulWidget {
  static const routeName = 'student_home_view';
  const StudentHomeView({Key? key}) : super(key: key);

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Buddy you are at Student page'),
      ),
    ));
  }
}
