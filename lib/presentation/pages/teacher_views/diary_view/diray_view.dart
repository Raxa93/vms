
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fu_vms/presentation/configurations/size_config.dart';
import 'package:fu_vms/presentation/pages/teacher_views/diary_view/diary_edit_view.dart';
import 'package:fu_vms/presentation/pages/teacher_views/diary_view/diary_vm.dart';
import 'package:fu_vms/presentation/utils/i_utills.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/diary_model.dart';

class DiaryView extends StatefulWidget {
  String teacherEmail = '';
   DiaryView({super.key,required this.teacherEmail});

  @override
  _DiaryView createState() => _DiaryView();
}

class _DiaryView extends State<DiaryView> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;

  @override
  void dispose() {
    context.read<DiaryViewModel>().descriptionController.dispose();
    context.read<DiaryViewModel>().titleController.dispose();
    context.read<DiaryViewModel>().selectedDate = DateTime.now();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<DiaryViewModel>().getTeacherNotes(widget.teacherEmail);
    _selectedDate = DateTime.now();

  }



   _submitForm(DiaryViewModel vm) async {
    if (_formKey.currentState!.validate()) {

       bool success = await vm.saveNoteToTeacher(widget.teacherEmail,context);
      if(success == true){
        iUtills().showMessage(context: context, title: 'Success', text: 'Notes Saved successfully');
        vm.selectedDate = DateTime.now();
        vm.titleController.text = '';
        vm.descriptionController.text = '';
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<DiaryViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create your Note'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: vm.titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },

                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: vm.descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },

                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text('Date: ${_selectedDate.toString().substring(0, 10)}'),
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
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: (){
                      _submitForm(vm);
                    },
                    child: const Text('Save'),
                  ),
                  const Divider(indent: 3,endIndent: 3,thickness: 1.5),
            Flexible(

                child: StreamBuilder<List<TeacherNote>>(
                    stream: vm.teacherNotes,
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
                        return Container(
                          // color: Colors.grey.withOpacity(0.1),
                          height: SizeConfig.screenHeight! * 0.5,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              // final TeacherNote note = notes[index];

                              return InkWell(
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                    title: Text(
                                      snapshot.data![index].title.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index].description.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    trailing: Column(
                                      children: [

                                        SizedBox(
                                          width : 70,
                                          child: Row(

                                            children: [
                                              InkWell(
                                                  onTap: (){
                                                    FirebaseFirestore.instance
                                                        .collection('teachers')
                                                        .doc(widget.teacherEmail)
                                                        .update({
                                                      'notes' : FieldValue.arrayRemove(
                                                          [snapshot.data![index].toMap()]
                                                      )
                                                    });
                                                  },
                                                  child: const Icon(Icons.delete,color: Colors.red,)),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).push(
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              DiaryEditView(
                                                                teacherEmail: widget.teacherEmail,
                                                                index: index,
                                                                timeTableModel: snapshot.data![index],
                                                              )));
                                                },
                                                child: Icon(Icons.edit),
                                              )
                                            ],

                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          snapshot.data![index].timestamp != '' ? DateFormat('MMM d, yyyy').format(DateTime.parse(snapshot.data![index].timestamp)) : '',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
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
        );
      },

    );
  }
}

