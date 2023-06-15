import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/utils/utils_extensions.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/teacher_model.dart';
import '../../../configurations/size_config.dart';
import '../student_home_view/student_home_view.dart';
import 'meeting_request_view.dart';

class TeacherDetailScreen extends StatefulWidget {
  final TeacherModel teacher;

  const TeacherDetailScreen({Key? key, required this.teacher})
      : super(key: key);

  @override
  State<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen> {
  List<String> availableTimeSlots = [];
  bool showTimeSlot = false;

  @override
  void initState() {
    // generateAvailableTimeSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teacher Detail'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()async{
                    await generateAvailableTimeSlots();

                  },
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            await generateAvailableTimeSlots();
                          },
                          child: const Icon(Icons.calendar_month,color: Colors.blue,)),
                      const SizedBox(width: 10),
                      const Text('Pick Date to show Slots',style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                showTimeSlot ?   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Teacher ${widget.teacher.teacherName} Free Time Slots',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : const SizedBox(),
                showTimeSlot ?    SizedBox(
                  height: SizeConfig.screenHeight! * 0.3,
                  child: ListView.builder(
                    itemCount: availableTimeSlots.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          String timeSlot = '8:00 AM - 8:30 AM';
                          List<String> timeComponents = timeSlot.split(' - ');

                          String startTime = timeComponents[0]; // 8:00 AM
                          String endTime = timeComponents[1];
                          print('Start time ${startTime}');
                          print('End time ${endTime}');
                          _showRequestDialog(
                              context, widget.teacher, startTime, endTime);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            availableTimeSlots[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ) : const SizedBox(),
                const Divider(indent: 4, endIndent: 4, thickness: 1.5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Teacher ${widget.teacher.teacherName} Time Table',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                    // color: Colors.grey.withOpacity(0.1),
                    height: SizeConfig.screenHeight! * 0.6,
                    child: ListView.builder(
                      itemCount: widget.teacher.teacherTimeTable.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final timeSlot = timeSlots[index];

                        return InkWell(
                          onLongPress: () {
                            // List<String> availableTimeSlots = generateTimeSlots().where((slot) {
                            //   // Filter out time slots that exist in the given list of data
                            //   bool isSlotAvailable = true;
                            //
                            //   for (var data in teacher.teacherTimeTable) {
                            //     DateTime startDate = DateTime.parse(data.startDate);
                            //     DateTime endDate = DateTime.parse(data.endDate);
                            //     DateTime slotStartTime = DateTime.parse(data.startTime);
                            //     DateTime slotEndTime = DateTime.parse(data.endTime);
                            //
                            //     if (startDate.isBefore(endDate)) {
                            //       // Check if the slot is within the start and end date range
                            //       if (slotStartTime.isBefore(slotEndTime) &&
                            //           startTime.isBefore(slotEndTime) &&
                            //           endTime.isAfter(slotStartTime)) {
                            //         isSlotAvailable = false;
                            //         break;
                            //       }
                            //     }
                            //   }
                            //
                            //   return isSlotAvailable;
                            // }).toList();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Text(
                                        'Venue',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Semester',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        widget
                                            .teacher.teacherTimeTable[index].room,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${widget.teacher.teacherTimeTable[index].semester}(${widget.teacher.teacherTimeTable[index].section})',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Start Time',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            widget.teacher.teacherTimeTable[index]
                                                .startTime,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'End Time',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            widget.teacher.teacherTimeTable[index]
                                                .endTime,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Date',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            DateTime.parse(widget
                                                    .teacher
                                                    .teacherTimeTable[index]
                                                    .startDate)
                                                .toWeekdayString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRequestDialog(BuildContext context, TeacherModel teacher,
      String startTime, String endTime) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Request Meeting'),
          content:
              const Text('Do you want to request a meeting at this time slot?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => RequestMeetingView(
                          teacher: teacher,
                          startTime: startTime,
                          endTime: endTime,
                        )));
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _submitRequest(
    BuildContext context,
  ) {
    // TODO: Submit appointment request to teacher and show confirmation message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text(
              'Your appointment request has been submitted and is awaiting approval from the teacher.'),
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

  Future generateAvailableTimeSlots() async {
    print('let me generate time slots');
    print('teacher email i got ${widget.teacher.teacherTimeTable.first.teacherEmail}');
    List<String> timeSlots = [];

    final DateFormat timeFormat = DateFormat('h:mm a');
    DateTime startTime = DateTime(0, 1, 1, 8); // Start time at 8:00 AM
    DateTime endTime = DateTime(0, 1, 1, 16); // End time at 4:00 PM

    while (startTime.isBefore(endTime)) {
      DateTime endTimeSlot = startTime.add(Duration(minutes: 30));
      String startTimeString = timeFormat.format(startTime);
      String endTimeString = timeFormat.format(endTimeSlot);

      String timeSlot = '$startTimeString - $endTimeString';
      timeSlots.add(timeSlot);
      startTime = endTimeSlot; // Move to the next time slot
    }
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(const Duration(days: 7)), // Example: limit to 7 days from today
    );
    CollectionReference meetingsCollection = FirebaseFirestore.instance
          .collection('teachers')
          .doc(widget.teacher.teacherTimeTable.first.teacherEmail)
          .collection('meetings');
if(selectedDate != null) {
  QuerySnapshot meetingsSnapshot = await meetingsCollection.where(
      'startDateTime', isEqualTo: selectedDate.formatDateToString()).get();
  print('I got meeting ${meetingsSnapshot.docs.length}');
  setState(() {
    availableTimeSlots = List<String>.from(timeSlots);
    for (var meetingDoc in meetingsSnapshot.docs) {
      // DateTime slotStartDate = DateTime.parse(teacherSlot.startDate);
      DateTime teacherStartTime = timeFormat.parse(meetingDoc['startTime']);
      DateTime teacherEndTime = timeFormat.parse(meetingDoc['endTime']);

      availableTimeSlots.removeWhere((slot) {
        DateTime slotStartTime = timeFormat.parse(slot.split(' - ')[0]);
        DateTime slotEndTime = timeFormat.parse(slot.split(' - ')[1]);

        bool isOverlapping = (teacherStartTime.isBefore(slotEndTime) &&
            slotStartTime.isBefore(teacherEndTime));

        return isOverlapping;
      });
    }
    final currentDayOfWeek = DateFormat('EEEE').format(DateTime.now());

    for (var teacherSlot in widget.teacher.teacherTimeTable) {
      DateTime slotStartDate = DateTime.parse(teacherSlot.startDate);

      // Check if the slot start day is equal to the current day of the week
      if (slotStartDate.weekday == selectedDate.weekday) {
        DateTime teacherStartTime = timeFormat.parse(teacherSlot.startTime);
        DateTime teacherEndTime = timeFormat.parse(teacherSlot.endTime);

        availableTimeSlots.removeWhere((slot) {
          DateTime slotStartTime = timeFormat.parse(slot.split(' - ')[0]);
          DateTime slotEndTime = timeFormat.parse(slot.split(' - ')[1]);

          bool isOverlapping = (teacherStartTime.isBefore(slotEndTime) &&
              slotStartTime.isBefore(teacherEndTime));

          return isOverlapping;
        });
      }
    }
    // for (var teacherSlot in widget.teacher.teacherTimeTable) {
    //   DateTime slotStartDate = DateTime.parse(teacherSlot.startDate);
    //
    //   if (slotStartDate.year == selectedDate.year &&
    //       slotStartDate.month == selectedDate.month &&
    //       slotStartDate.day == selectedDate.day) {
    //     DateTime teacherStartTime = timeFormat.parse(teacherSlot.startTime);
    //     DateTime teacherEndTime = timeFormat.parse(teacherSlot.endTime);
    //
    //     availableTimeSlots.removeWhere((slot) {
    //       DateTime slotStartTime = timeFormat.parse(slot.split(' - ')[0]);
    //       DateTime slotEndTime = timeFormat.parse(slot.split(' - ')[1]);
    //
    //       bool isOverlapping = (teacherStartTime.isBefore(slotEndTime) &&
    //           slotStartTime.isBefore(teacherEndTime));
    //
    //       return isOverlapping;
    //     });
    //   }   }
    showTimeSlot = true;
  });
}
  }
//   Future<void> generateAvailableTimeSlots() async {
//     List<String> timeSlots = [];
//     timeSlots.clear();
//     final DateFormat timeFormat = DateFormat('h:mm a');
//     DateTime startTime = DateTime(0, 1, 1, 8); // Start time at 8:00 AM
//     DateTime endTime = DateTime(0, 1, 1, 16); // End time at 4:00 PM
//
//     while (startTime.isBefore(endTime)) {
//       DateTime endTimeSlot = startTime.add(Duration(minutes: 30));
//       String startTimeString = timeFormat.format(startTime);
//       String endTimeString = timeFormat.format(endTimeSlot);
//       print('This is local time format ${startTimeString}');
//       String timeSlot = '$startTimeString - $endTimeString';
//       timeSlots.add(timeSlot);
//       startTime = endTimeSlot; // Move to the next time slot
//     }
//
//     // Get the selected date from the date picker
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now()
//           .add(Duration(days: 7)), // Example: limit to 7 days from today
//     );
//
//     if (selectedDate != null) {
//       DateTime startOfDay =
//           DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
//       DateTime endOfDay = startOfDay.add(Duration(days: 1));
//       String pickedDate = selectedDate!.formatDateToString();
//       CollectionReference meetingsCollection = FirebaseFirestore.instance
//           .collection('teachers')
//           .doc(widget.teacher.teacherTimeTable.first.teacherEmail)
//           .collection('meetings');
//
//       QuerySnapshot meetingsSnapshot = await meetingsCollection.where('startDateTime', isEqualTo: pickedDate).get();
//
//
//       for (var meetingDoc in meetingsSnapshot.docs) {
//         Map<String, dynamic> meetingData =
//             meetingDoc.data() as Map<String, dynamic>;
//         DateTime teacherStartTime = timeFormat.parse(meetingData['startTime']);
//         DateTime teacherEndTime = timeFormat.parse(meetingData['endTime']);
// print('Start Time ${teacherStartTime}');
// print('Start Time ${teacherEndTime}');
//         availableTimeSlots.removeWhere((slot) {
//           print(' I am inside remove where');
//           DateTime slotStartTime = timeFormat.parse(slot.split(' - ')[0]);
//           DateTime slotEndTime = timeFormat.parse(slot.split(' - ')[1]);
//
//           bool isOverlapping = (teacherStartTime.isBefore(slotEndTime) &&
//               slotStartTime.isBefore(teacherEndTime));
//
//           return isOverlapping;
//         });
//       }
//     }
//
//     setState(() {
//       availableTimeSlots = List<String>.from(timeSlots);
//     });
//   }

  DateTime parseTime(String timeString) {
    List<String> timeParts = timeString.split(' ');
    List<String> hourMinuteParts = timeParts[0].split(':');
    int hour = int.parse(hourMinuteParts[0]);
    int minute = int.parse(hourMinuteParts[1]);
    bool isAM = timeParts[1] == 'AM';

    // Convert to 24-hour format
    if (!isAM && hour < 12) {
      hour += 12;
    } else if (isAM && hour == 12) {
      hour = 0;
    }

    return DateTime(0, 1, 1, hour, minute);
  }
}
