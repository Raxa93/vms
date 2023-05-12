import 'package:flutter/material.dart';
import 'package:fu_vms/presentation/components/custom_text_field.dart';
import 'package:fu_vms/presentation/configurations/size_config.dart';
import 'package:fu_vms/presentation/constants/app_styles.dart';
import 'package:fu_vms/presentation/pages/teacher_views/data_entry_view/teacher_data_entry_vm.dart';
import 'package:provider/provider.dart';


class TeacherDataEntryView extends StatefulWidget {
  static const routeName = 'teacher_home_view';

  const TeacherDataEntryView({Key? key}) : super(key: key);

  @override
  State<TeacherDataEntryView> createState() => _TeacherDataEntryViewState();
}

class _TeacherDataEntryViewState extends State<TeacherDataEntryView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Teachers Data Collection'),
      ),
      body: Consumer<TeacherDataEntryViewModel>(
        builder: (context, vm, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  const Text('Dear Teacher Please Enter Your Data',
                      style: AppStyle.headline3),
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  CustomTextField(
                    label: 'Name',
                    hint: 'Name',
                    controller: vm.nameController,
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  CustomTextField(
                    label: 'Phone Number',
                    hint: 'Phone Number',
                    controller: vm.phoneController,
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {

                            await vm.saveTeacherData(context).then((value) {


                            });
                          }
                        },
                        child: const Text('Save Data')),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
