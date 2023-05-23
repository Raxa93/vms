

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/pages/students_view/student_data_entry/student_data_entry_vm.dart';
import 'package:fu_vms/presentation/utils/i_utills.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text_field.dart';
import '../../../configurations/size_config.dart';
import '../../../constants/app_styles.dart';

class StudentDataEntryView extends StatefulWidget {
  const StudentDataEntryView({Key? key}) : super(key: key);

  @override
  State<StudentDataEntryView> createState() => _StudentDataEntryViewState();
}

class _StudentDataEntryViewState extends State<StudentDataEntryView> {
  final _formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Teachers Data Collection'),
          ),
          body: Consumer<StudentDataEntryViewModel>(
            builder: (context, vm, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        const Text('Dear Student Please Enter Your Data',
                            style: AppStyle.headline3),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: vm.imageFile != null ? FileImage(vm.imageFile!) : null,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () async {
                                final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  vm.setImageFile(File(pickedFile.path));
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CustomTextField(
                          label: 'Name',
                          hint: 'Name',
                          controller: vm.nameController,
                          validator: vm.passwordValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CustomTextField(
                          label: 'Phone Number',
                          hint: 'Phone Number',
                          controller: vm.phoneController, validator: vm.passwordValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CustomTextField(
                          label: 'Semester',
                          hint: 'Semester',
                          controller: vm.semesterController, validator: vm.passwordValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CustomTextField(
                          label: 'Section',
                          hint: 'Section',
                          controller: vm.sectionController, validator: vm.passwordValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CustomTextField(
                          label: 'Shift',
                          hint: 'Shift',
                          controller: vm.shiftController, validator: vm.passwordValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        CustomTextField(
                          label: 'Session',
                          hint: 'Session',
                          controller: vm.sessionController, validator: vm.passwordValidator,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                if(vm.imageFile == null){
                                  iUtills().showMessage(context: context, title: 'Warning', text: 'Picture is required');
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {

                                  await vm.saveStudentData(context).then((value) {


                                  });
                                }
                              },
                              child: const Text('Save Data')),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
