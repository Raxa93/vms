import 'package:flutter/material.dart';

class DocumentView extends StatelessWidget {
  static const routeName = 'document_view';
  List<Map<String, dynamic>> documents = [
    {
      'documentId': '1',
      'name': 'Assignment 1',
      'uploadedBy': 'John Doe',
      'uploadedTime': '2022-04-01 13:30:00',
      'semester': 'Spring 2022',
      'url': 'https://www.example.com/assignment1.pdf',
    },
    {
      'documentId': '2',
      'name': 'Lab Report 2',
      'uploadedBy': 'Jane Smith',
      'uploadedTime': '2022-04-02 10:15:00',
      'semester': 'Spring 2022',
      'url': 'https://www.example.com/labreport2.pdf',
    },
    {
      'documentId': '3',
      'name': 'Project Proposal',
      'uploadedBy': 'Bob Johnson',
      'uploadedTime': '2022-04-03 16:45:00',
      'semester': 'Fall 2021',
      'url': 'https://www.example.com/projectproposal.pdf',
    },
  ];


    DocumentView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Uploaded Documents'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final document = documents[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Uploaded by: ${documents[index]['uploadedBy']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Uploaded time: ${documents[index]['uploadedTime']}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Student semester: ${documents[index]['semester']}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  documents[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Download document
                                },
                                icon: const Icon(Icons.file_download),
                                label: const Text('Download'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
