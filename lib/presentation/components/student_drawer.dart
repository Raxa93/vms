
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fu_vms/presentation/pages/login/login_view.dart';

class StudentDrawer extends StatefulWidget {

  StudentDrawer({Key? key}) : super(key: key);

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
                // Text(
                //   widget.teacherName.toUpperCase(),
                //   style: const TextStyle(
                //     fontSize: 18.0,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.outbound_outlined),
            title: const Text('Logout'),
            onTap: ()async {
              // TODO: Handle Student List tap
              final FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();

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
                  title: Text('Exit App'),
                  content: Text('Do you really want to exit?'),
                  actions: [
                    ElevatedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemChannels.platform
                                .invokeMethod<void>('SystemNavigator.pop');
                          }
                          // SystemNavigator.pop();
                        }),
                    ElevatedButton(
                        child: Text('No'),
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
