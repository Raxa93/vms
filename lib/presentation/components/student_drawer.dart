import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fu_vms/presentation/pages/login/login_view.dart';

class StudentDrawer extends StatefulWidget {
String studentName;
String studentImage;
String studentEmail;
  StudentDrawer({Key? key,required this.studentImage,required this.studentName,required this.studentEmail}) : super(key: key);

  @override
  State<StudentDrawer> createState() => _StudentDrawer();
}

class _StudentDrawer extends State<StudentDrawer> {
  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.green],
              ),
            ),
            accountName:  Text(
             widget.studentName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              widget.studentEmail,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            currentAccountPicture:  CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white, // Set a fallback background color
              backgroundImage: NetworkImage(widget.studentImage),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.outbound_outlined),
            title: const Text('Logout'),
            onTap: () async {
              // TODO: Handle Student List tap
              final FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();

              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => LoginView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () {
              showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('Exit App'),
                  content: const Text('Do you really want to exit?'),
                  actions: [
                    ElevatedButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemChannels.platform
                              .invokeMethod<void>('SystemNavigator.pop');
                        }
                        // SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(c, false);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
