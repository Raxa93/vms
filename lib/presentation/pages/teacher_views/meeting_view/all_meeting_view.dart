import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fu_vms/presentation/pages/teacher_views/meeting_view/history.dart';

import '../../../utils/i_utills.dart';
import '../approval_view/approval_pending_screeen.dart';

class MeetingScreen extends StatefulWidget {
  final String teacherEmail;

  const MeetingScreen({required this.teacherEmail});

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _meetingsStream;

  @override
  void initState() {
    super.initState();
    _meetingsStream = FirebaseFirestore.instance
        .collection('teachers')
        .doc(widget.teacherEmail)
        .collection('meetings')
        .where('inProgress', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
        actions: [
          InkWell(
              onTap: (){
                Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context) =>
                            MeetingHistoryScreen(
                              teacherEmail: widget.teacherEmail,
                            )));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.history),
              )),
          InkWell(
              onTap: (){
                Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context) =>
                            MeetingApprovalScreen(
                              teacherEmail: widget.teacherEmail,
                            )));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.approval),
              )),
        ],
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _meetingsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No meetings found'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var meetingDoc = snapshot.data!.docs[index];
              var meetingData = meetingDoc.data();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      meetingData['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meetingData['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Venue: ${meetingData['venue']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Start Time: ${meetingData['startDateTime']} (${meetingData['startTime']})',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'End Time: ${meetingData['endDateTime']} (${meetingData['endTime']})',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Meeting with: ${meetingData['meetingWith'] ?? 'Not required'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    trailing: ElevatedButton(
                      child: const Text('End Meeting'),
                     onPressed: () async {
                    var abc =   await  _openDialog(context).then((value) {
                      var meetingDocRef = FirebaseFirestore.instance
                          .collection('teachers')
                          .doc(widget.teacherEmail)
                          .collection('meetings')
                          .doc(meetingDoc.id);
                      meetingDocRef.set({'feedBack': value},SetOptions(merge: true));
                      });

                       var meetingDocRef = FirebaseFirestore.instance
                           .collection('teachers')
                           .doc(widget.teacherEmail)
                           .collection('meetings')
                           .doc(meetingDoc.id);
                       meetingDocRef.update({'inProgress': false});
                       iUtills().showMessage(context: context, title: 'Success', text: 'Meeting Ended');
                     },
                    ),
                    onTap: () {
                      // Handle onTap event for each meeting
                      // You can navigate to a detailed view or perform any other action
                      print('Tapped on meeting: ${meetingData['title']}');
                    },
                  ),
                ),
              );
            },
          );

        },
      ),
    );
  }

  Future<String?> _openDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Give Feed Back'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
            ),
          ],
        );
      },
    );
  }
}

