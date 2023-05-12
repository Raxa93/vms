import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../teacher_views/appointment_creation_view/new_appointment_creation_view.dart';
import '../student_home_view/student_home_view.dart';

class TeacherDetailScreen extends StatelessWidget {
  final Teacher teacher;

  const TeacherDetailScreen({Key? key, required this.teacher}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        teacher.name,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        teacher.designation,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Divider(),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Available Time Slots',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          itemCount: teacher.availableTimeSlots.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final timeSlot = teacher.availableTimeSlots[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  title: Text('${timeSlot['day']}'),
                                  subtitle: Text('${timeSlot['time']}'),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                       _showRequestDialog(context);
                                    },
                                    child: const Text('Request'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  void _showRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Request Meeting'),
          content: Text('Do you want to request a meeting?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _submitRequest(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _submitRequest(BuildContext context,) {
    // TODO: Submit appointment request to teacher and show confirmation message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text('Your appointment request has been submitted and is awaiting approval from the teacher.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
