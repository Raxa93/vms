import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingHistoryScreen extends StatefulWidget {
  final String teacherEmail;

  const MeetingHistoryScreen({required this.teacherEmail});

  @override
  _MeetingHistoryScreen createState() => _MeetingHistoryScreen();
}

class _MeetingHistoryScreen extends State<MeetingHistoryScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _meetingsStream;

  @override
  void initState() {
    super.initState();
    _meetingsStream = FirebaseFirestore.instance
        .collection('teachers')
        .doc(widget.teacherEmail)
        .collection('meetings')
        .where('inProgress', isEqualTo: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),

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
                          'Date: ${meetingData['startDateTime']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Time: ${meetingData['startTime']} to ${meetingData['endTime']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Meeting With : ${meetingData['meetingWith'] ?? 'Not Required'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    onTap: () {

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

