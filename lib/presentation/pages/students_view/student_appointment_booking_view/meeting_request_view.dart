
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/students_view/student_appointment_booking_view/student_meeting_request_vm.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/models/teacher_model.dart';
import '../../../../locator.dart';

class RequestMeetingView extends StatefulWidget {
  TeacherModel teacher;
  String startTime;
  String endTime;
   RequestMeetingView({Key? key,required this.teacher,required this.startTime,required this.endTime}) : super(key: key);

  @override
  State<RequestMeetingView> createState() => _RequestMeetingViewState();
}

class _RequestMeetingViewState extends State<RequestMeetingView> {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
 String studentName = '';
  @override
  void initState() {
    studentName = _localStorageService.getStudentName;
    print('This is student name $studentName');
    super.initState();
  }

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
                      // TextFormField(
                      //   controller: vm.roomController,
                      //   decoration: const InputDecoration(labelText: 'Venue'),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter the room';
                      //     }
                      //     return null;
                      //   },
                      // ),

                      ElevatedButton(
                          onPressed: ()async {

                            if (_formKey.currentState!.validate()) {
                              await vm.saveMeeting(widget.teacher.teacherTimeTable.first.teacherEmail, context,widget.startTime,widget.endTime).then((value) {
                                sendNotifications(teacherName: widget.teacher.teacherName,
                              teacherFcm: widget.teacher.token,
                                   endTime: widget.endTime,
                                  startTime: widget.startTime,
                                  studentName: studentName,

                                );

                              });
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



  void sendNotifications({required String teacherFcm, required  String teacherName, required  String startTime, required String endTime, required  String studentName}) async {
    const String serverKey = 'AAAApmPcZ3g:APA91bHpDR5ojrP6bUA3v1Pnp4sfSWhNfxrUnjdlRALpRu-yb6vREOJhnh06m6MK1zrdEc8sQfC4NwcxSg5_i_i94aGV55LxrHRjE27RK_BEk4dpPB8RDFYAGCMiwlx1vqR3s1F-bbQa';

    const String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    Map<String, dynamic> notification = {
      'title': 'Meeting Request Received',
      'body': 'Dear $teacherName, You have received meeting request from $studentName from $startTime To $endTime',
    };

    Map<String, dynamic> requestBody = {
      'notification': notification,
      'to': teacherFcm,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

}
