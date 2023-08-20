import 'package:flutter/material.dart';

import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Frontend/AuthenticationDialog.dart';
import 'package:topcalls/Frontend/CloudLogs.dart';
import 'package:topcalls/Frontend/Consts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenlength = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: FirebaseServiceProvider().connect(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.none) {
          if (Authservice().cloud_user == null) {
            return const SigninPage();
          }
          return const CloudLogsPage();
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
