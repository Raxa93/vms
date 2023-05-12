
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/constants/app_styles.dart';
import 'package:fu_vms/presentation/pages/teacher_views/documents_view/documents_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard_views/teacher_dashboard_vm.dart';
import 'package:provider/provider.dart';

import '../appointment_creation_view/new_appointment_creation_view.dart';
import '../approval_view/approval_screen.dart';

class TeacherDashBoardScreen extends StatefulWidget {
  static const routeName = 'teacher_dash_board_view';
  const TeacherDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoardScreen> createState() => _TeacherDashBoardScreenState();
}

class _TeacherDashBoardScreenState extends State<TeacherDashBoardScreen> {
  final List<Map<String, String>> students = [
    {'name': 'Alice', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 10:00', 'end': 'May 10, 2023 11:00'},
    {'name': 'Bob', 'semester': 'Summer 2023', 'start': 'Jan 10, 2023 10:00', 'end': 'May 10, 2023 11:00'},
    {'name': 'Charlie', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 11:00', 'end': 'May 10, 2023 12:00'},
    {'name': 'Dave', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 11:00', 'end': 'May 10, 2023 13:00'},
    {'name': 'Emily', 'semester': 'Summer 2023', 'start': 'Jan 10, 2023 12:00', 'end': 'May 10, 2023 13:00'},
    {'name': 'Frank', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 14:00', 'end': 'May 10, 2023 15:00'},
    {'name': 'Gina', 'semester': 'Summer 2023', 'start': 'Jan 10, 2023 14:00', 'end': 'May 10, 2023 16:00'},
    {'name': 'Harry', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 15:00', 'end': 'May 10, 2023 15:30'},
    {'name': 'Isabel', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 15:00', 'end': 'May 10, 2023 16:00'},
    {'name': 'Jack', 'semester': 'Spring 2023', 'start': 'Jan 10, 2023 15:00', 'end': 'May 10, 2023 16:00'},
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherDashBoardVm>(
      builder: (context, vm, child) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.green,
                child: const Icon(Icons.add,color: Colors.white,),
                onPressed: (){
                  // vm.saveMeeting();
                   Navigator.pushNamed(context, TimeSlotsScreen.routeName);
              // vm.selectDateTimeRange(context);
            }),
            appBar: AppBar(title: const Text('Teacher DashBoard'),actions:  [

              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, DocumentView.routeName);
                  },
                  child: const Icon(Icons.edit_document)),
              const SizedBox(width: 5),
               InkWell(
                   onTap: (){
                     Navigator.pushNamed(context, WaitingApprovalScreen.routeName);
                   },
                   child: const Icon(Icons.approval_rounded)),
              const SizedBox(width: 5),
            ],),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:   [
                  const SizedBox(height: 15),
                  const Text('Your Schedule Meetings',style: AppStyle.headline3),
                    const SizedBox(height: 15),
                    const Divider(indent: 2,endIndent: 2,thickness: 2.0,),
              Expanded(

                // height: 200,
                child:  ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: ListTile(
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            leading: Container(
                              padding: const EdgeInsets.only(right: 12),
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 1, color: Colors.grey),
                                ),
                              ),
                              child: const Icon(Icons.school, color: Colors.grey),
                            ),
                            title:  Text(
                              'Student Name : ${students[index]['name'].toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'Semester: ${students[index]['semester'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Start Date: ${students[index]['start'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'End Date: ${students[index]['end'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            // trailing: const Icon(Icons.arrow_forward, color: Colors.grey, size: 30),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
