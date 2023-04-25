import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherDashBoardScreen extends StatefulWidget {
  static const routeName = 'teacher_dash_board_view';
  const TeacherDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoardScreen> createState() => _TeacherDashBoardScreenState();
}

class _TeacherDashBoardScreenState extends State<TeacherDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : const Text('Teacher DashBoard')),
      body: const Center(
        child: Text('Teacher Dash Board'),
      ),
    );
  }
}
