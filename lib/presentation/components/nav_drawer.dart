
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
                color: Colors.green[400]
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

        ],
      ),
    );

  }
}
