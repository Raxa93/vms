
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/students_view/student_home_view/student_home_vm.dart';
import 'package:provider/provider.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/models/teacher_model.dart';
import '../../../../locator.dart';
import '../../../components/student_drawer.dart';
import '../../../configurations/size_config.dart';
import '../file_uplaoding_view/file_uploading_view.dart';
import '../student_appointment_booking_view/book_appointment_view.dart';




class StudentHomeView extends StatefulWidget {
  static const routeName = 'student_home_view';
  const StudentHomeView({Key? key}) : super(key: key);

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

   String studentName = '';
   String studentImage = '';
   String studentEmail = '';
  @override
  void initState() {
    Provider.of<StudentHomeViewModel>(context, listen: false).getTeachers();
    studentName = _localStorageService.getStudentName;
    studentImage = _localStorageService.getStudentImage;
    studentEmail = _localStorageService.getEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<StudentHomeViewModel>(
      builder: (context, vm, child) {
        return SafeArea(
          child: Scaffold(
drawer: StudentDrawer(studentName: studentName,studentImage: studentImage,studentEmail: studentEmail),
            appBar: AppBar(
              title: const Text('Student DashBoard'),
            ),
            body: StreamBuilder<List<TeacherModel>>(
              stream: vm.allTeachers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if  (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Teacher Data Found'),
                  );
                }
                else{
                  return SizedBox(
                    height: SizeConfig.screenHeight! * 0.5,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final teacher = snapshot.data![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(teacher.imageUrl),
                              ),
                              title: Text(teacher.teacherName),
                              subtitle: Text(teacher.phoneNumber),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // TODO: Navigate to teacher's profile page
                                // print('This is available slot ${teacher.availableTimeSlots.first['day']}');
print('Lists item is ${teacher.teacherTimeTable.length}');
                                Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            TeacherDetailScreen(
                                                teacher: teacher)));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

              }
            ),
          ),
        );
      },

    );
  }
}
