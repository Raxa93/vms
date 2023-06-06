
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fu_vms/data/models/time_table_model.dart';
import 'package:fu_vms/presentation/pages/teacher_views/time_table_view/time_table_vm.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/diary_model.dart';
import '../../../utils/i_utills.dart';
import 'diary_vm.dart';

class DiaryEditView extends StatefulWidget {
  String teacherEmail = '';
  TeacherNote timeTableModel;
  int index;
  DiaryEditView({Key? key,required this.teacherEmail,required this.index,required this.timeTableModel}) : super(key: key);

  @override
  State<DiaryEditView> createState() => _DiaryEditViewState();
}

class _DiaryEditViewState extends State<DiaryEditView> {
  late DateTime _selectedDate;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DiaryViewModel>().titleController.text = widget.timeTableModel.title.toString();
      context.read<DiaryViewModel>().descriptionController.text = widget.timeTableModel.description.toString();
      context.read<DiaryViewModel>().selectedDate = DateTime.parse(widget.timeTableModel.timestamp);
    });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryViewModel>(
      builder: (context, vm, child) {
        return WillPopScope(
          onWillPop: () {
            return onBackPress(context);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Notes Edit'),
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
                            return 'Please enter the Title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: vm.descriptionController,
                        decoration: const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Description';
                          }
                          return null;
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text('Date: ${vm.selectedDate.toString().substring(0, 10)}'),
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null && pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                              vm.selectedDate = pickedDate;
                            });
                          }
                        },
                      ),


                      ElevatedButton(
                          onPressed: ()async {
                            if (_formKey.currentState!.validate()) {
                              bool success = await vm.updateTimetableEntry(widget.teacherEmail, context,widget.index);
                              if(success == true){
                                iUtills().showMessage(context: context, title: 'Success', text: 'Diary Updated successfully');
                                vm.titleController.text = '';
                                vm.descriptionController.text = '';

                                // Navigator.of(context).pop();
                                //  Navigator.pop(context);
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