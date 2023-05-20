
import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/students_view/student_appointment_booking_view/student_meeting_request_vm.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/teacher_model.dart';

class RequestMeetingView extends StatefulWidget {
  TeacherModel teacher;
  String startTime;
  String endTime;
   RequestMeetingView({Key? key,required this.teacher,required this.startTime,required this.endTime}) : super(key: key);

  @override
  State<RequestMeetingView> createState() => _RequestMeetingViewState();
}

class _RequestMeetingViewState extends State<RequestMeetingView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingRequestVm>(
      builder: (context, vm, child) {
        return WillPopScope(
          onWillPop: () {
            return onBackPress(context);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Create Meeting Request'),
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: vm.titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: vm.descriptionController,
                        decoration: const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the semester';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: vm.roomController,
                        decoration: const InputDecoration(labelText: 'Venue'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the room';
                          }
                          return null;
                        },
                      ),

                      ElevatedButton(
                          onPressed: ()async {

                            if (_formKey.currentState!.validate()) {
                              await vm.saveMeeting(widget.teacher.teacherTimeTable.first.teacherEmail, context,widget.startTime,widget.endTime);
                              // if(success == true){
                              //   // iUtills().showMessage(context: context, title: 'Success', text: 'TimeTable Updated successfully');
                              //   vm.sectionController.text = '';
                              //   vm.semesterController.text = '';
                              //   vm.roomController.text = '';
                              //   vm.fromTimeController.text = '';
                              //   vm.fromDateController.text = '';
                              //   vm.toTimeController.text = '';
                              //   vm.fromTimeController.text = '';
                              //   // Navigator.of(context).pop();
                              //   // Navigator.pop(context);
                              // }

                            }
                          },
                          child: const Text('Save')),
                      const SizedBox(height: 10),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onBackPress(BuildContext context) {
    Navigator.pop(context);
    context.read<MeetingRequestVm>().destroyModel();
    return Future.value(false);
  }
}
