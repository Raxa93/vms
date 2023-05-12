import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../teacher_dashboard_views/teacher_dashboard_vm.dart';

class TimeSlotsScreen extends StatelessWidget {
  final List<TimeSlot> timeSlots = [
    TimeSlot(startTime: '8:00 AM', endTime: '9:00 AM',startDate: 'May 13',endDate: 'May 13',),
    TimeSlot(startTime: '9:00 AM', endTime: '10:00 AM',startDate: 'May 14',endDate: 'May 14',),
    TimeSlot(startTime: '10:00 AM', endTime: '11:00 AM',startDate: 'May 14,',endDate: 'May 15',),
    TimeSlot(startTime: '11:00 AM', endTime: '12:00 PM',startDate: 'May 16',endDate: 'May 16',),
    TimeSlot(startTime: '12:00 PM', endTime: '1:00 PM',startDate: 'May 17',endDate: 'May 17',),
    TimeSlot(startTime: '1:00 PM', endTime: '2:00 PM',startDate: 'May 19',endDate: 'May 19',),
    TimeSlot(startTime: '2:00 PM', endTime: '3:00 PM',startDate: 'May 22',endDate: 'May 22',),
    TimeSlot(startTime: '3:00 PM', endTime: '4:00 PM',startDate: 'May 22',endDate: 'May 22',),
    TimeSlot(startTime: '4:00 PM', endTime: '5:00 PM',startDate: 'May 22',endDate: 'May 23',),
    TimeSlot(startTime: '5:00 PM', endTime: '6:00 PM',startDate: 'May 24',endDate: 'May 24',),
  ];
  static const routeName = 'time_slots_view';

   TimeSlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Slots'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
                         Padding(
                padding:  const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
                    context.read<TeacherDashBoardVm>().selectDateTimeRange(context);
                  },
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Select Date and Time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          context.read<TeacherDashBoardVm>().selectDateTimeRange(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              const Divider(indent: 15 , endIndent: 15,thickness: 1.0,),
        const Text('Your Available Time Slots'),
        SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: timeSlots.length,
            itemBuilder: (BuildContext context, int index) {
              final timeSlot = timeSlots[index];

              return Container(
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
                      const Text(
                        'Time Slot',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${timeSlot.startDate} - ${timeSlot.endDate}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                timeSlot.startTime,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                timeSlot.endTime,
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
              );
            },
          ),

        ),
            ],
          ),
        ),
      ),
    );
  }
}
class TimeSlot {
  String startTime;
  String endTime;
  String startDate;
  String endDate;

  TimeSlot({required this.startTime, required this.endTime,required this.startDate,required this.endDate});
}