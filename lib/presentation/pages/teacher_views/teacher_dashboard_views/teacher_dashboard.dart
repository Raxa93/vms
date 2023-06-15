
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fu_vms/presentation/components/nav_drawer.dart';
import 'package:fu_vms/presentation/configurations/size_config.dart';
import 'package:fu_vms/presentation/pages/teacher_views/diary_view/diray_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard_views/teacher_dashboard_vm.dart';
import 'package:provider/provider.dart';

import '../meeting_view/all_meeting_view.dart';
import '../meeting_view/new_meeting_view.dart';
import '../student_list_view/student_list_view.dart';
import '../time_table_view/time_table_view.dart';


class TeacherDashBoardScreen extends StatefulWidget {
  static const routeName = 'teacher_dash_board_view';
  const TeacherDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoardScreen> createState() => _TeacherDashBoardScreenState();
}

class _TeacherDashBoardScreenState extends State<TeacherDashBoardScreen> {

  @override
  void initState() {
    context.read<TeacherDashBoardVm>().getValueFromDisk();
    context.read<TeacherDashBoardVm>().getValueDataFromFireBase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<TeacherDashBoardVm>(
      builder: (context, vm, child) {
        return WillPopScope(
          onWillPop: (() => showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you really want to exit?'),
              actions: [
                ElevatedButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemChannels.platform
                            .invokeMethod<void>('SystemNavigator.pop');
                      }
                      // SystemNavigator.pop();
                    }),
                ElevatedButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.pop(c, false);
                    }),
              ],
            ),
          ).then((value) => value!)) ,
          child: SafeArea(
            child: Scaffold(
              drawer:  NavDrawer(teacherName: vm.teacherName),
              appBar: AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green.shade700, Colors.green.shade400],
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green.shade700, Colors.green.shade400],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [

                            const Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  vm.teacherName.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),


                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white, // Set a fallback background color
                            backgroundImage: NetworkImage(vm.teacherImage),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedContainer(
                        onTap: () {
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) =>
                                       DiaryView(
                                         teacherEmail: vm.teacherEmail,
                                      )));
                        },
                        icon: Icons.book,
                        text: 'My Diary',
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      RoundedContainer(
                        onTap: () {
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      TimeTableView(
                                        teacherEmail: vm.teacherEmail,
                                      )));
                        },
                        icon: Icons.calendar_month,
                        text: 'Time Table',
                      ),

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedContainer(
                        onTap: () {
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const StudentListView(

                                  )));
                        },
                        icon: Icons.people,
                        text: 'Student List',
                      ),
                      // RoundedContainer(
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //         CupertinoPageRoute(
                      //             builder: (context) =>
                      //                 NewMeetingView(
                      //                   teacherEmail: vm.teacherEmail,
                      //                 )));
                      //   },
                      //   icon: Icons.create,
                      //   text: 'Create Meetings',
                      // ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      RoundedContainer(
                        onTap: () {
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      MeetingScreen(
                                        teacherEmail: vm.teacherEmail,
                                      )));
                        },
                        icon: Icons.history,
                        text: 'My Meetings',
                      ),

                    ],
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     RoundedContainer(
                  //       onTap: () {
                  //         Navigator.of(context).push(
                  //             CupertinoPageRoute(
                  //                 builder: (context) =>
                  //                     const StudentListView(
                  //
                  //                     )));
                  //       },
                  //       icon: Icons.people,
                  //       text: 'Student List',
                  //     ),
                  //     SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  //     // RoundedContainer(
                  //     //   onTap: () {
                  //     //
                  //     //   },
                  //     //   icon: Icons.group,
                  //     //   text: 'Groups',
                  //     // ),
                  //   ],
                  // ),
                ],
              ),
            )
            ,
          ),
        );
      }
    );
  }
}


class RoundedContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const RoundedContainer({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade400, Colors.green.shade300],
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.white,
            ),
            const SizedBox(height: 16.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}








