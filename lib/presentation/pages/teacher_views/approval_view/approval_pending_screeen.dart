import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fu_vms/presentation/utils/i_utills.dart';
import 'package:http/http.dart' as http;
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
                          'Start Time: ${meetingData['startTime']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'End Time: ${meetingData['endTime']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(

                      child: const Text('Approved'),
                      onPressed: ()async{
                        EasyLoading.show();
                        print('requestedBy email : ${meetingData['requestedFrom']}');
                        final docSnap = await FirebaseFirestore.instance
                            .collection('students')
                            .doc(meetingData['requestedFrom'])
                            .get();
                        final data = docSnap.data();
                        final fcmToken = data?['fcmToken'] as String?;
                        var meetingDocRef = FirebaseFirestore.instance
                            .collection('teachers')
                            .doc(widget.teacherEmail)
                            .collection('meetings')
                            .doc(meetingDoc.id);
                        meetingDocRef.update({'approved': true})
                            .then((_) {
                          EasyLoading.dismiss();
                             sendNotifications(date: meetingData['startDateTime'],studentFcm: fcmToken.toString(), teacherName: widget.teacherEmail,startTime: meetingData['startTime'],endTime: meetingData['endTime']);
                         iUtills().showMessage(context: context, title: 'Success', text: 'Meeting approved');
                        }).catchError((error) {
                          EasyLoading.dismiss();
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

  void sendNotifications({required String studentFcm, required  String teacherName, required  String startTime, required String endTime,required String date}) async {
    const String serverKey = 'AAAApmPcZ3g:APA91bHpDR5ojrP6bUA3v1Pnp4sfSWhNfxrUnjdlRALpRu-yb6vREOJhnh06m6MK1zrdEc8sQfC4NwcxSg5_i_i94aGV55LxrHRjE27RK_BEk4dpPB8RDFYAGCMiwlx1vqR3s1F-bbQa';

    const String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    Map<String, dynamic> notification = {
      'title': 'Meeting Request Approved',
      'body': 'Dear Student, Your meeting request with $teacherName from $startTime To $endTime on $date is approve.kindly be on time',
    };

    Map<String, dynamic> requestBody = {
      'notification': notification,
      'to': studentFcm,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

}

