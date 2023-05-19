import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fu_vms/data/models/time_table_model.dart';
import 'package:fu_vms/presentation/pages/teacher_views/time_table_view/time_table_edit_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/time_table_view/time_table_vm.dart';
import 'package:fu_vms/presentation/utils/utils_extensions.dart';
import 'package:provider/provider.dart';

import '../../../configurations/size_config.dart';
import '../../../utils/i_utills.dart';

class TimeTableView extends StatefulWidget {
  String teacherEmail = '';
  static const routeName = 'time_slots_view';

  TimeTableView({super.key, required this.teacherEmail});

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    context.read<TimeTableVm>().getTeacherTimeTable(widget.teacherEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<TimeTableVm>(
      builder: (context, vm, child) {
        return WillPopScope(
          onWillPop: () {
            return onBackPress(context);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Time Table'),
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: vm.sectionController,
                        decoration: const InputDecoration(labelText: 'Section'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the section';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: vm.semesterController,
                        decoration: const InputDecoration(labelText: 'Semester'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the semester';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: vm.roomController,
                        decoration: const InputDecoration(labelText: 'Room'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the room';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
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
                              bool success = await vm.saveTimetableEntry(widget.teacherEmail, context);
                              if(success == true){
                                iUtills().showMessage(context: context, title: 'Success', text: 'TimeTable Saved successfully');
                                vm.sectionController.text = '';
                                vm.semesterController.text = '';
                                vm.roomController.text = '';
                                vm.fromTimeController.text = '';
                                vm.fromDateController.text = '';
                                vm.toTimeController.text = '';
                                vm.fromTimeController.text = '';
                              }

                            }
                          },
                          child: const Text('Save')),
                      const SizedBox(height: 10),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                        thickness: 1.0,
                      ),
                      const Text('Your Available Time Slots'),
                      Flexible(

                        child: StreamBuilder<List<TimeTableModel>>(
                            stream: vm.teacherTimeTable,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text('No Data Found'),
                                );
                              }
                              // print(snapshot.data);
                              else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return SizedBox(
                                  // color: Colors.grey.withOpacity(0.1),
                                    height: SizeConfig.screenHeight! * 0.5,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        // final timeSlot = timeSlots[index];
                                        final arrayField = 'timetable';
                                        return InkWell(
                                          onLongPress: (){
                                            print('I am pressed long');
                                            FirebaseFirestore.instance
                                                .collection('teachers')
                                                .doc(widget.teacherEmail)
                                                .update({
                                              'timeTable' : FieldValue.arrayRemove(
                                                  [snapshot.data![index].toJson()]
                                              )
                                            });
                                          },
                                          onTap: (){
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        TimeTableEditView(
                                                          teacherEmail: widget.teacherEmail,
                                                          index: index,
                                                          timeTableModel: snapshot.data![index],
                                                        )));
                                          },
                                          // onTap: (){
                                          //   print('Snapshot ${snapshot.data![index].documentId;}');
                                          // },
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
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                     children: [
                                                       Text(
                                                         snapshot.data![index].room,
                                                         style: const TextStyle(
                                                           color: Colors.black,
                                                           fontSize: 16.0,
                                                           fontWeight: FontWeight.bold,
                                                         ),
                                                       ),
                                                       Text(
                                                         '${snapshot.data![index].semester}(${snapshot.data![index].section})',
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
                                                        children:  [
                                                          const Text(
                                                            'Start Time',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 8.0),
                                                          Text(
                                                            '${snapshot.data![index].startTime}',
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
                                                        children:  [
                                                          const Text(
                                                            'End Time',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 8.0),
                                                          Text(
                                                            '${snapshot.data![index].endTime}',
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
                                                        children:  [
                                                          const Text(
                                                            'Date',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 8.0),
                                                          Text(
                                                            '${snapshot.data![index].startDate}',
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
                                    )
                                );
                              } else {
                                return const Center(
                                  child: Text('No Data Found'),
                                );
                              }
                            }),
                      )

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
    context.read<TimeTableVm>().destroyModel();
    return Future.value(false);
  }
}
