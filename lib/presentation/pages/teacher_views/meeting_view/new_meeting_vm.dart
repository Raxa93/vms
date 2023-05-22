
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/presentation/pages/teacher_views/meeting_view/new_meeting_view.dart';
import 'package:fu_vms/presentation/utils/utils_extensions.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

import '../../../../data/models/meeting_data_model.dart';
import '../../../../data/models/meeting_model.dart';
import '../../../utils/i_utills.dart';
import 'all_meeting_view.dart';

class NewMeetingVm extends ChangeNotifier{


  DateTime classDate = DateTime.now();
  TimeOfDay classTime = const TimeOfDay(hour: 00, minute: 00);
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  TimeOfDay? pickedFromTime, pickedToTime;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final teacherCollection = _db.collection('teachers');
  Stream<List<Meeting>>? meetings ;
  pickStartDate(context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024))
        .then((pickedDate) async {
      if (pickedDate != null) {
        fromDateController.text = pickedDate.formatDateToString();
        print('From date controller is ${fromDateController.text}');
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

  saveMeeting(String teacherEmail,context) async {
    EasyLoading.show();
    var newMeeting = Meeting(
      title: titleController.text,
      description: descriptionController.text,
      startDateTime: fromDateController.text ,
      endDateTime: toDateController.text ,
      startTime: fromTimeController.text,
      endTime: toTimeController.text,
      approved: true,
      venue: roomController.text,
      inProgress: true,
      requestedFrom: teacherEmail
    );
    try {

   await   teacherCollection.doc(teacherEmail).collection('meetings').add(
          newMeeting.toJson()

      );
   EasyLoading.dismiss();

      // await meetingsCollection.add(meeting.toJson());
      iUtills().showMessage(context: context, title: 'Success', text: 'Meeting Saved');
   Navigator.of(context).push(
       CupertinoPageRoute(
           builder: (context) =>
               MeetingScreen(
                 teacherEmail: teacherEmail,
               )));
    } catch (e) {
      EasyLoading.dismiss();
      print('Error saving meeting: $e');
      iUtills().showMessage(context: context, title: 'OOpss', text: 'Something went wrong');
      rethrow;
    }
  }





  Future<void> fetchMeetings(String teacherEmail) async {
    CollectionReference meetingsCollection = _db.collection('teachers').doc(teacherEmail).collection('meetings');
    try {
      QuerySnapshot meetingsSnapshot = await meetingsCollection.get();
      List<QueryDocumentSnapshot> meetingDocs = meetingsSnapshot.docs;

      // Process the meeting documents
       meetings = meetingDocs.map((doc) {
        var data = doc.data();
        print('Data type: ${data.runtimeType}');
        return Meeting.fromJson(data as Map<String, dynamic>);
      }) as Stream<List<Meeting>>;


      // Do something with the meetings data
      print(meetings);
    } catch (e) {
      print('Error fetching meetings: $e');
      // Handle the error
    }
  }

destroyModel(){
    titleController.text = '';
    descriptionController.text = '';
    roomController.text = '';
    fromTimeController.text = '';
    toTimeController.text = '';
    fromDateController.text = '';
    fromTimeController.text = '';
    notifyListeners();
}

}