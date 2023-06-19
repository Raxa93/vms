
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:fu_vms/data/models/meeting_data_model.dart';
import 'package:fu_vms/data/models/teacher_model.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/repositories/teacher_repo/teacher_repo_imp.dart';
import '../../../../locator.dart';

class TeacherDashBoardVm extends ChangeNotifier{

  // DateTime _startDateTime = DateTime.now();
  // DateTime _endDateTime = DateTime.now();.
  String teacherName = '';
  String teacherEmail = '';
  String teacherImage = '';
  final teacherFireStoreRepo = GetIt.instance.get<TeacherRepoImp>();
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  final teacherCollection = _db.collection('teachers');
 TeacherModel? teacher;


 set setTeacherName(var newVal) {
   teacherName = newVal;
   notifyListeners();
 }

  set setTeacherImage(var newVal) {
    teacherImage = newVal;
    notifyListeners();
  }

  getValueDataFromFireBase() async {

      try {
      var data =  await teacherCollection.doc(_localStorageService.getEmail).get();
          teacher = TeacherModel.fromSnapshot(data);
          if(teacher != null){
            setTeacherName = teacher!.teacherName.toString();
            setTeacherImage = teacher!.imageUrl.toString();
            _localStorageService.setTeacherName = teacher!.teacherName.toString();
            _localStorageService.setTeacherImage = teacher!.imageUrl.toString();
            print('Teacher image $teacherImage');
          }

      } on FirebaseException catch (e) {
        debugPrint("Exception in Fav $e");
        rethrow;
      }

  }

  getValueFromDisk(){
   teacherName = _localStorageService.getTeacherName;
   teacherEmail = _localStorageService.getEmail;
   teacherImage = _localStorageService.getTeacherImage;
  }

   selectDateTimeRange(context) async {
      await showDatePicker(
         context: context,
         initialDate: DateTime.now(),
         firstDate: DateTime.now(),
         lastDate:  DateTime(2025, 12, 31)).then((pickedDate) {
           if(pickedDate != null){
             // print('Buddy this is date i picked ${pickedDate}');
             return showDialog(
               context: context,
               builder: (_) => Expanded(
                 child: FromToTimePicker(
                   onTab: (from, to) {
                     // print('from $from to $to');
                   },
                   dialogBackgroundColor: const Color(0xFF121212),
                   fromHeadlineColor: Colors.white,
                   toHeadlineColor: Colors.white,
                   upIconColor: Colors.white,
                   downIconColor: Colors.white,
                   timeBoxColor: const Color(0xFF1E1E1E),
                   timeHintColor: Colors.grey,
                   timeTextColor: Colors.white,
                   dividerColor: const Color(0xFF121212),
                   doneTextColor: Colors.white,
                   dismissTextColor: Colors.white,
                   defaultDayNightColor: const Color(0xFF1E1E1E),
                   defaultDayNightTextColor: Colors.white,
                   colonColor: Colors.white,
                   showHeaderBullet: true,
                   headerText: 'Please select your available hours',
                 ),
               ),
             );
           }
     });

// print('Date ${dateTimeList.first.startDateTime }');
    }

    saveMeeting() async{
    var newMeeting = MeetingModel(
         studentName: 'Test Student',
         startTime: '10',
         endTime: '14',
         semester: 'Seventh',
         meetingWith: 'razaahmad93@gmail.com');
    List newMeetings = [];
      newMeetings.add({'Student':newMeeting.toMap()});
     teacherFireStoreRepo.saveMeetings(newMeetings);
    }
  }


