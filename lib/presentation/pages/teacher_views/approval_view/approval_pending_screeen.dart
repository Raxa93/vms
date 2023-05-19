import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fu_vms/presentation/utils/i_utills.dart';

class MeetingApprovalScreen extends StatefulWidget {
  final String teacherEmail;

  const MeetingApprovalScreen({required this.teacherEmail});

  @override
  _MeetingApprovalScreen createState() => _MeetingApprovalScreen();
}

class _MeetingApprovalScreen extends State<MeetingApprovalScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _meetingsStream;

  @override
  void initState() {
    super.initState();
    _meetingsStream = FirebaseFirestore.instance
        .collection('teachers')
        .doc(widget.teacherEmail)
        .collection('meetings')
        .where('inProgress', isEqualTo: true)
        .where('approved', isEqualTo: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval'),

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
                          'Start Time: ${meetingData['startDateTime']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'End Time: ${meetingData['endDateTime']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(

                      child: const Text('Approved'),
                      onPressed: (){
                        var meetingDocRef = FirebaseFirestore.instance
                            .collection('teachers')
                            .doc(widget.teacherEmail)
                            .collection('meetings')
                            .doc(meetingDoc.id);
                        meetingDocRef.update({'approved': true})
                            .then((_) {
                         iUtills().showMessage(context: context, title: 'Success', text: 'Meeting approved');
                        }).catchError((error) {
                          iUtills().showMessage(context: context, title: 'OOpss', text: 'Something went wrong');
                          print('Failed to approve meeting: $error');
                        });
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
}

