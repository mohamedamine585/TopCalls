import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topcalls/Backend/Cloud_user.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/CacheService.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Frontend/AccountPage.dart';
import 'package:topcalls/Frontend/AuthenticationDialog.dart';
import 'package:topcalls/Frontend/CloudLogs.dart';
import 'package:topcalls/Frontend/Configuration.dart';
import 'package:topcalls/Frontend/RegisterDialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final user = Authservice().cloud_user;
    return FutureBuilder(
      future: FirebaseServiceProvider().connect(),
      builder: (context, snapshot) {
        if (user == null) {
          return const SigninPage();
        }
        return const CloudLogsPage();
      },
    );
  }
}
