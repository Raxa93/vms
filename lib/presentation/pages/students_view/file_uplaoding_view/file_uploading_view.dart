import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentScreen extends StatefulWidget {
  @override
  _UploadDocumentScreenState createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  File? _selectedFile;
  bool _uploading = false;

  Future<void> _uploadFile() async {
    setState(() {
      _uploading = true;
    });

    // Simulate file uploading with a 2-second delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _uploading = false;
      _selectedFile = null;
    });

    // Show upload success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document uploaded successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _selectFile() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select a document to upload',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectFile,
              child: const Text('Choose File'),
            ),
            const SizedBox(height: 16.0),
            if (_selectedFile != null)
              Text(
                'Selected file: ${_selectedFile!.path}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectedFile == null || _uploading
                  ? null
                  : _uploadFile,
              child: _uploading
                  ? const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              )
                  : const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
