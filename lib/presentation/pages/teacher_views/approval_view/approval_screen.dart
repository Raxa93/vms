import 'package:flutter/material.dart';

class AppointmentRequest {
  final String studentName;
  final String date;
  final String timeSlot;
  final String reason;

  AppointmentRequest({
    required this.studentName,
    required this.date,
    required this.timeSlot,
    required this.reason,
  });
}

class WaitingApprovalScreen extends StatefulWidget {
  static const routeName = 'approval_pending_view';

  const WaitingApprovalScreen({super.key});
  @override
  _WaitingApprovalScreenState createState() => _WaitingApprovalScreenState();
}

class _WaitingApprovalScreenState extends State<WaitingApprovalScreen> {
  List<AppointmentRequest> appointmentRequests = [
    AppointmentRequest(
      studentName: 'John Doe',
      date: 'May 20, 2023',
      timeSlot: '9:00 AM - 10:00 AM',
      reason: 'Need to discuss exam preparation',
    ),
    AppointmentRequest(
      studentName: 'Jane Smith',
      date: 'May 21, 2023',
      timeSlot: '11:00 AM - 12:00 PM',
      reason: 'Need to discuss course projects',
    ),
    AppointmentRequest(
      studentName: 'Bob Johnson',
      date: 'May 22, 2023',
      timeSlot: '2:00 PM - 3:00 PM',
      reason: 'Need to discuss career opportunities',
    ),
    AppointmentRequest(
      studentName: 'Sarah Lee',
      date: 'May 23, 2023',
      timeSlot: '4:00 PM - 5:00 PM',
      reason: 'Need to discuss course syllabus',
    ),
    AppointmentRequest(
      studentName: 'Tom Wilson',
      date: 'May 24, 2023',
      timeSlot: '9:00 AM - 10:00 AM',
      reason: 'Need to discuss research ideas',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointment Requests'),
        ),
        body: ListView.builder(
          itemCount: appointmentRequests.length,
          itemBuilder: (context, index) {
            final appointmentRequest = appointmentRequests[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    appointmentRequest.studentName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded, color: Colors.grey, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text(
                            appointmentRequest.date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.watch_later_rounded, color: Colors.grey, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text(
                            appointmentRequest.timeSlot,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.book_rounded, color: Colors.grey, size: 18.0),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              'Reason: ${appointmentRequest.reason}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle),
                        color: Colors.green,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Approve Appointment Request'),
                                content: const Text('Are you sure you want to approve this appointment request?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // TODO: Approve appointment request
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Approve'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.cancel),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Reject Appointment Request'),
                                content: const Text('Are you sure you want to reject this appointment request?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // TODO: Approve appointment request
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Approve'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );

          },
        ),
      ),
    );
  }
}
