
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/presentation/utils/i_utills.dart';
import 'package:fu_vms/presentation/utils/utils_extensions.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

import '../../../../data/models/time_table_model.dart';

class TimeTableVm extends ChangeNotifier{

  DateTime classDate = DateTime.now();
  TimeOfDay classTime = const TimeOfDay(hour: 00, minute: 00);
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController subjetController = TextEditingController();
  TimeOfDay? pickedFromTime, pickedToTime;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final teacherCollection = _db.collection('teachers');
  Stream<List<TimeTableModel>>? teacherTimeTable;

  pickStartDate(context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024))
        .then((pickedDate) async {
      if (pickedDate != null) {
        fromDateController.text = pickedDate.formatDateToString();
        if(toDateController.text.isNotEmpty){
          if(DateTime.parse(fromDateController.text).isAfter(DateTime.parse(toDateController.text))){
            iUtills().showMessage(context: context, title: 'Error', text: 'End Date Cannot be before Start Date');
            fromDateController.text = '';
            toDateController.text = '';
            fromTimeController.clear();
            toTimeController.clear();
notifyListeners();
            return;
          }
        }

      }
      TimeOfDay? pickedTime = await showIntervalTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        interval: 15,
        visibleStep: VisibleStep.fifteenths,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        },
      );
      if(pickedTime != null){

        pickedFromTime = pickedTime;
        String formattedTimes= pickedTime.format(context);
        pickedFromTime = pickedTime;
        fromTimeController.text = formattedTimes;
        bool isPickedTimeBeforeCurrentTime = false;
        if (pickedDate!.isAfter(DateTime.now())) {
          isPickedTimeBeforeCurrentTime = false;
        }
        else{
          isPickedTimeBeforeCurrentTime = _checkTimes(pickedTime, DateTime.now());
        }

        if(isPickedTimeBeforeCurrentTime){
          iUtills().showMessage(context: context, title: 'Error', text: 'End Date Cannot be before Start Date');
          fromTimeController.clear();
          fromDateController.clear();
          notifyListeners();
        }
        else{

        }
      }
    });

  }

  pickEndDate(context) async {
    if(fromDateController.text.isEmpty){
      return;
    }
    showDatePicker(
        context: context,
        initialDate: DateTime.parse(fromDateController.text),
        firstDate: DateTime.parse(fromDateController.text),
        lastDate: DateTime(2024))
        .then((pickedDate) async {
      if (pickedDate != null) {
        toDateController.text = pickedDate.formatDateToString();
       notifyListeners();
      }
      TimeOfDay? pickedTime = await showIntervalTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        interval: 15,
        visibleStep: VisibleStep.fifteenths,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        },
      );
      if(pickedTime != null){
        // DateTime parsedTime =
        // DateFormat.jm().parse(pickedTime.format(context).toString());
        // String formattedTime = DateFormat('HH:mm').format(parsedTime);
        pickedToTime = pickedTime;
        String formattedTimes = pickedTime.format(context);
        toTimeController.text = formattedTimes;
        pickedToTime = pickedTime;
        if(DateTime.parse(fromDateController.text).isSameDate(DateTime.parse(toDateController.text))){
          var timeCorrect = _checkTimes(pickedFromTime, pickedToTime);
          if(timeCorrect){}
          else{
            iUtills().showMessage(context: context, title: 'Error', text: 'End Date Cannot be before Start Date');
            toDateController.clear();
            toTimeController.clear();
            notifyListeners();
          }
        }

      }
    });
    notifyListeners();
  }
  bool _checkTimes(startTime, endTime) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
    if (endTimeInt > startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> saveTimetableEntry(String teacherEmail,context) async {
    EasyLoading.show();
    var newTimeTable = TimeTableModel(
        teacherEmail: teacherEmail,
        section: sectionController.text,
        semester: semesterController.text,
        room: roomController.text,
        startDate: fromDateController.text,
        endDate: toDateController.text,
        startTime: fromTimeController.text,
        endTime: toTimeController.text,
    subject: subjetController.text
    );
    try {
      final DocumentReference teacherDocRef = teacherCollection.doc(teacherEmail); // Get the teacher document reference
      await  teacherDocRef.update({
        'timeTable': FieldValue.arrayUnion([newTimeTable.toJson()])
      });
      EasyLoading.dismiss();
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      iUtills().showMessage(context: context, title: 'OOpssss', text: e.toString());
      return false;

    } catch (e) {
      EasyLoading.dismiss();
      iUtills().showMessage(context: context, title: 'OOppsss', text: 'Something went wrong');
      return false;

    }
  }
  Future<bool> updateTimetableEntry(String teacherEmail,context,index) async {
    EasyLoading.show();
    final DocumentReference teacherDocRef = teacherCollection.doc(teacherEmail);
    final DocumentSnapshot teacherDocSnapshot = await teacherDocRef.get();
    final Map<String, dynamic> data = teacherDocSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> notes = data['timeTable'];

    var updateTimeTable = TimeTableModel(
        teacherEmail: teacherEmail,
        section: sectionController.text,
        semester: semesterController.text,
        room: roomController.text,
        startDate: fromDateController.text,
        endDate: toDateController.text,
        startTime: fromTimeController.text,
        subject: subjetController.text,
        endTime: toTimeController.text);
    notes[index] = updateTimeTable.toJson();
    try {
       // Get the teacher document reference
      notes[index] =updateTimeTable.toJson();
      await teacherDocRef.update({'timeTable': notes});
      // await  teacherDocRef.update({
      //   '$arrayField.$index': updateTimeTable.toJson(),
      // });
      EasyLoading.dismiss();
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      iUtills().showMessage(context: context, title: 'OOpssss', text: e.toString());
      return false;

    } catch (e) {
      EasyLoading.dismiss();
      iUtills().showMessage(context: context, title: 'OOppsss', text: 'Something went wrong');
      return false;

    }
  }

  getTeacherTimeTable(String teacherEmail)  {
    try {
      teacherTimeTable = teacherCollection.doc(teacherEmail).snapshots().map(
            (snapshot) => (snapshot.data()?['timeTable'] as List<dynamic>)
            .map((timeTable) => TimeTableModel.fromJson(timeTable))
            .toList(),
      );

      // teacherTimeTable = teacherCollection.doc(teacherEmail).snapshots().map(
      //       (snapshot) => (snapshot.data()?['notes'] as List<dynamic>)
      //       .map((note) => TeacherNote.fromMap(note))
      //       .toList(),
      // );
    } catch (e) {
      debugPrint('Exception in Get Tours $e');
      rethrow;
    }
  }

  destroyModel(){
    sectionController.text = '';
    semesterController.text = '';
    roomController.text = '';
    fromTimeController.text = '';
    toTimeController.text = '';
    fromDateController.text = '';
    fromTimeController.text = '';
    notifyListeners();
  }
}