
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/teacher_views/student_list_view/student_list_vm.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/stduent_model.dart';
import '../../../configurations/size_config.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({Key? key}) : super(key: key);

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  String searchQuery = '';
  @override
  void initState() {
    Provider.of<StudentListVm>(context, listen: false).getStudents();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<StudentListVm>(
      builder: (context, vm, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Student List'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(

                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    hintText: 'Search by Student Name or semester',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
            ),
            body: StreamBuilder<List<StudentModel>>(
              stream: vm.allStudents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Students found'),
                  );
                } else {
                  final filteredStudents =  snapshot.data!
                      .where((student) =>
                  student.studentName.toLowerCase().contains(searchQuery.toLowerCase()) ||
                      student.semester.toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();

                  return SizedBox(
                    height: SizeConfig.screenHeight! * 0.5,
                    child: ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final student = filteredStudents[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            height: SizeConfig.screenHeight! * 0.14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(student.imageUrl),
                              ),
                              title: Text(
                                student.studentName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        student.phoneNumber,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Icon(Icons.school, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${student.semester} (${student.section})',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        student.shift,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Text(
                                student.session,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                // TODO: Navigate to student's profile page
                                // Navigator.of(context).push(
                                //   CupertinoPageRoute(
                                //     builder: (context) => StudentDetailScreen(
                                //       student: student,
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
