
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fu_vms/presentation/pages/login/login_view.dart';

import '../../data/datasources/local/preferences_service.dart';
import '../../locator.dart';

class NavDrawer extends StatefulWidget {
  String teacherName = '';
   NavDrawer({Key? key,required this.teacherName}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade700, Colors.green.shade400],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.teacherName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('My Diary'),
            onTap: () {
              // TODO: Handle My Diary tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.meeting_room),
            title: const Text('Request for Meeting'),
            onTap: () {
              // TODO: Handle Request for Meeting tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              // TODO: Handle History tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Create Meetings'),
            onTap: () {
              // TODO: Handle Create Meetings tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Groups'),
            onTap: () {
              // TODO: Handle Groups tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Student List'),
            onTap: () {
              // TODO: Handle Student List tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.outbound_outlined),
            title: const Text('Logout'),
            onTap: ()async {
              // TODO: Handle Student List tap
              final FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
_localStorageService.setIsLoggedIn = false;
_localStorageService.setIsStudentDataSaved = false;
_localStorageService.setIsTeacherDataSaved = false;
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                      builder: (context) =>
                          LoginView(

                          )));
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
                        }),
                    ElevatedButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(c, false);
                        }),
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
