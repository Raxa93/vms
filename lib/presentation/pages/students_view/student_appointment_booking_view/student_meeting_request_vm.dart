
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/models/meeting_model.dart';
import '../../../../locator.dart';
import '../../../utils/i_utills.dart';
import '../student_home_view/student_home_view.dart';
import 'book_appointment_view.dart';

class MeetingRequestVm extends ChangeNotifier{


  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController roomController = TextEditingController();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final teacherCollection = _db.collection('teachers');
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();

  Future saveMeeting(String teacherEmail,context,startTime,endTime) async {
   String userEmail = _localStorageService.getEmail;
    EasyLoading.show();
    var newMeeting = Meeting(
        title: titleController.text,
        description: descriptionController.text,
        startDateTime: DateTime.now().toString(),
        endDateTime: DateTime.now().toString(),
        startTime: startTime,
        endTime: endTime,
        approved: false,
        venue: roomController.text,
        inProgress: true,
      requestedFrom: userEmail
    );
    try {

      await   teacherCollection.doc(teacherEmail).collection('meetings').add(
          newMeeting.toJson()

      );
      EasyLoading.dismiss();

      // await meetingsCollection.add(meeting.toJson());
      iUtills().showMessage(context: context, title: 'Success', text: 'Meeting Saved');
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
              builder: (context) =>
                  StudentHomeView(

                  )));
    } catch (e) {
      EasyLoading.dismiss();
      print('Error saving meeting: $e');
      iUtills().showMessage(context: context, title: 'OOpss', text: 'Something went wrong');
      rethrow;
    }
  }



  destroyModel(){
    titleController.text = '';
    descriptionController.text = '';
    roomController.text = '';
    notifyListeners();
  }

}