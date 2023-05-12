
import 'package:flutter/material.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:fu_vms/data/models/meeting_data_model.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/repositories/teacher_repo/teacher_repo_imp.dart';

class TeacherDashBoardVm extends ChangeNotifier{

  // DateTime _startDateTime = DateTime.now();
  // DateTime _endDateTime = DateTime.now();
  final teacherFireStoreRepo = GetIt.instance.get<TeacherRepoImp>();

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


