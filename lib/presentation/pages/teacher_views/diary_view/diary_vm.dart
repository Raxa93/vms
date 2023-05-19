import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/datasources/local/preferences_service.dart';
import '../../../../data/models/diary_model.dart';
import '../../../../locator.dart';
import '../../../utils/i_utills.dart';

class DiaryViewModel extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final teacherCollection = _db.collection('teachers');
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  final List<TeacherNote> notes = [];
  Stream<List<TeacherNote>>? teacherNotes;




   getTeacherNotes(String teacherEmail)  {
  try {
    teacherNotes = teacherCollection.doc(teacherEmail).snapshots().map(
          (snapshot) => (snapshot.data()?['notes'] as List<dynamic>)
          .map((note) => TeacherNote.fromMap(note))
          .toList(),
    );

  } catch (e) {
    debugPrint('Exception in Get Tours $e');

    rethrow;
  }
  }


  Future saveNoteToTeacher(String teacherEmail, context) async {
    EasyLoading.show();
    var newNote = TeacherNote(
        title: titleController.text,
        description: descriptionController.text,
        timestamp: selectedDate.toString());
    try {
      final DocumentReference teacherDocRef = teacherCollection.doc(teacherEmail); // Get the teacher document reference
     await  teacherDocRef.update({
        'notes': FieldValue.arrayUnion([newNote.toMap()])
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
}
