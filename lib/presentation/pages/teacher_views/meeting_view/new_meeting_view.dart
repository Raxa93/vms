


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../data/models/stduent_model.dart';
import 'new_meeting_vm.dart';

class NewMeetingView extends StatefulWidget {
  String teacherEmail = '';
  StudentModel studentModel ;

  NewMeetingView({Key? key,required this.teacherEmail,required this.studentModel}) : super(key: key);

  @override
  State<NewMeetingView> createState() => _NewMeetingView();
}

class _NewMeetingView extends State<NewMeetingView> {

  @override
  void initState() {

    super.initState();
    print('Student token is ${widget.studentModel.token}');
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<NewMeetingVm>(
      builder: (context, vm, child) {
        return WillPopScope(
          onWillPop: () {
            return onBackPress(context);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title:  Text('Create Meeting with ${widget.studentModel.studentName.toString()}',style: TextStyle(fontSize: 14),),
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
                      // Text('Date :${vm.toDateController.text}'),
                      // const SizedBox(height: 16.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                // _presentTimePicker(true);
                                vm.pickStartDate(context);
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please Select Start Time";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select Start Time',
                                    labelText: 'Start Time',
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () => vm.pickStartDate(context),
                                      // _presentTimePicker(true),
                                      icon: const Icon(
                                        Icons.date_range,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  // validator: validateDob,
                                  controller: vm.fromTimeController,
                                  onSaved: (String? val) {},
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                // _presentTimePicker(false);
                                vm.pickEndDate(context);
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please Select End Time";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select End Time',
                                    labelText: 'End Time',
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                      // _presentTimePicker(false),
                                      vm.pickEndDate(context),
                                      icon: const Icon(
                                        Icons.date_range,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  // validator: validateDob,
                                  controller: vm.toTimeController,
                                  onSaved: (String? val) {
                                    // _appointment.toTime = val;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: ()async {

                            if (_formKey.currentState!.validate()) {
                               await vm.saveMeeting(widget.teacherEmail, context,widget.studentModel.studentName).whenComplete(() {
                                 sendNotifications(
                                   teacherName: widget.teacherEmail,
                                   venue: vm.roomController.text,
                                   endTime: vm.toTimeController.text,
                                   startTime: vm.fromTimeController.text,
                                   studentFcm: widget.studentModel.token,
                                   date: vm.fromDateController.text

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
    context.read<NewMeetingVm>().destroyModel();
    return Future.value(false);
  }

  void sendNotifications({required String date,required String studentFcm, required  String teacherName,required String venue ,required  String startTime, required String endTime}) async {
    const String serverKey = 'AAAApmPcZ3g:APA91bHpDR5ojrP6bUA3v1Pnp4sfSWhNfxrUnjdlRALpRu-yb6vREOJhnh06m6MK1zrdEc8sQfC4NwcxSg5_i_i94aGV55LxrHRjE27RK_BEk4dpPB8RDFYAGCMiwlx1vqR3s1F-bbQa';

    const String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    Map<String, dynamic> notification = {
      'title': 'Meeting Created',
      'body': 'Dear Student, $teacherName has created meeting with you at $venue from $startTime to $endTime on $date',
    };

    Map<String, dynamic> requestBody = {
      'notification': notification,
      'to': studentFcm,
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
