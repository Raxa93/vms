import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/constants/app_styles.dart';
import 'package:fu_vms/presentation/pages/teacher_views/appointment_creation_view/new_appointment_creation_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/teacher_dashboard_views/teacher_dashboard_vm.dart';
import 'package:provider/provider.dart';

class TeacherDashBoardScreen extends StatefulWidget {
  static const routeName = 'teacher_dash_board_view';
  const TeacherDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoardScreen> createState() => _TeacherDashBoardScreenState();
}

class _TeacherDashBoardScreenState extends State<TeacherDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherDashBoardVm>(
      builder: (context, vm, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              child: const Icon(Icons.add,color: Colors.white,),
              onPressed: (){
                print('Get going');
                vm.saveMeeting();
                // Navigator.pushNamed(context, NewAppointmentCreationView.routeName);
            // vm.selectDateTimeRange(context);
          }),
          appBar: AppBar(title: const Text('Teacher DashBoard')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  const [
                SizedBox(height: 15),
                Text('Your Schedule Meetings',style: AppStyle.headline3),
                  SizedBox(height: 15),
                  Divider(indent: 2,endIndent: 2,thickness: 2.0,),

              ],
            ),
          ),
        );
      }
    );
  }
}
