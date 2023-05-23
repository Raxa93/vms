
import 'package:flutter/material.dart';
import 'package:fu_vms/data/models/time_table_model.dart';
import 'package:fu_vms/presentation/pages/teacher_views/time_table_view/time_table_vm.dart';
import 'package:provider/provider.dart';

import '../../../utils/i_utills.dart';

class TimeTableEditView extends StatefulWidget {
  String teacherEmail = '';
  TimeTableModel timeTableModel;
  int index;
   TimeTableEditView({Key? key,required this.teacherEmail,required this.index,required this.timeTableModel}) : super(key: key);

  @override
  State<TimeTableEditView> createState() => _TimeTableEditViewState();
}

class _TimeTableEditViewState extends State<TimeTableEditView> {

  @override
  void initState() {
    context.read<TimeTableVm>().sectionController.text = widget.timeTableModel.section.toString();
    context.read<TimeTableVm>().semesterController.text = widget.timeTableModel.semester.toString();
    context.read<TimeTableVm>().roomController.text = widget.timeTableModel.room.toString();
    context.read<TimeTableVm>().fromDateController.text = widget.timeTableModel.startDate.toString();
    context.read<TimeTableVm>().fromTimeController.text = widget.timeTableModel.startTime.toString();
    context.read<TimeTableVm>().toDateController.text = widget.timeTableModel.endDate.toString();
    context.read<TimeTableVm>().toTimeController.text = widget.timeTableModel.endTime.toString();
    context.read<TimeTableVm>().subjetController.text = widget.timeTableModel.subject.toString();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeTableVm>(
      builder: (context, vm, child) {
        return WillPopScope(
          onWillPop: () {
            return onBackPress(context);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Time Table Edit'),
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
                        controller: vm.subjetController,
                        decoration: const InputDecoration(labelText: 'Subject'),
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
                              bool success = await vm.updateTimetableEntry(widget.teacherEmail, context,widget.index);
                              if(success == true){
                                iUtills().showMessage(context: context, title: 'Success', text: 'TimeTable Updated successfully');
                                vm.sectionController.text = '';
                                vm.semesterController.text = '';
                                vm.roomController.text = '';
                                vm.fromTimeController.text = '';
                                vm.fromDateController.text = '';
                                vm.toTimeController.text = '';
                                vm.fromTimeController.text = '';
                                vm.subjetController.text = '';
                                // Navigator.of(context).pop();
                                // Navigator.pop(context);
                              }

                            }
                          },
                          child: const Text('Update')),
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
    context.read<TimeTableVm>().destroyModel();
    return Future.value(false);
  }
}
