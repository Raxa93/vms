
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../file_uplaoding_view/file_uploading_view.dart';
import '../student_appointment_booking_view/book_appointment_view.dart';


class Teacher {
  final String name;
  final String designation;
  final String department;
  final String imageUrl;
  final List<Map<String, String>> availableTimeSlots;


  Teacher({
    required this.name,
    required this.designation,
    required this.department,
    required this.imageUrl,
    required this.availableTimeSlots,
  });
}

final List<Teacher> teachers = [
  Teacher(
    name: 'Sara William',
    designation: 'Associate Professor',
    department: 'Computer Science',
    imageUrl: 'https://i.pravatar.cc/100?img=1',
      availableTimeSlots : [
      {'day': 'Monday', 'time': '10:00 AM - 12:00 PM'},
      {'day': 'Tuesday', 'time': '2:00 PM - 4:00 PM'},
      {'day': 'Thursday', 'time': '11:00 AM - 1:00 PM'},
      {'day': 'Friday', 'time': '12:00 AM - 1:00 PM'},
      {'day': 'Monday', 'time': '1:00 PM - 2:00 PM'},
      {'day': 'Tuesday', 'time': '11:00 AM - 1:00 PM'},
      ]
  ),
  Teacher(
    name: 'Jane Smith',
    designation: 'Assistant Professor',
    department: 'Mathematics',
    imageUrl: 'https://i.pravatar.cc/100?img=2',
      availableTimeSlots : [
        {'day': 'Monday', 'time': '10:00 AM - 12:00 PM'},
        {'day': 'Tuesday', 'time': '2:00 PM - 4:00 PM'},
        {'day': 'Thursday', 'time': '11:00 AM - 1:00 PM'},
      ]
  ),
  Teacher(
    name: 'Michael Johnson',
    designation: 'Professor',
    department: 'Physics',
    imageUrl: 'https://i.pravatar.cc/100?img=3',
      availableTimeSlots : [
        {'day': 'Monday', 'time': '10:00 AM - 12:00 PM'},
        {'day': 'Tuesday', 'time': '2:00 PM - 4:00 PM'},
        {'day': 'Thursday', 'time': '11:00 AM - 1:00 PM'},
      ]
  ),
];

class StudentHomeView extends StatelessWidget {
  static const routeName = 'student_home_view';
  const StudentHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).push(
                CupertinoPageRoute(
                    builder: (context) =>
                        UploadDocumentScreen(
                            )));
          }),
      appBar: AppBar(
        title: const Text('Student DashBoard'),
      ),
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (BuildContext context, int index) {
          final teacher = teachers[index];

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
                title: Text(teacher.name),
                subtitle: Text('${teacher.designation}, ${teacher.department}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // TODO: Navigate to teacher's profile page
                  print('This is available slot ${teacher.availableTimeSlots.first['day']}');

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
