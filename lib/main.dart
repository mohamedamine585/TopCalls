import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Cloud_user.dart';
import 'package:topcalls/Frontend/AuthenticationDialog.dart';
import 'package:topcalls/Frontend/CloudLogs.dart';
import 'package:topcalls/Frontend/Homepage.dart';
import 'package:topcalls/Frontend/RegisterDialog.dart';
import 'package:topcalls/Frontend/Sync&Cloud.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      "CloudLogsPage": (context) => const CloudLogsPage(), // to hold the place
      "Signin": (context) => const SigninPage(),
      "Homepage": (context) => const Homepage(),
      "Clouddata": (context) => const CloudContacts(),
      "Register": (context) => const RegisterPage(),
    },
    debugShowCheckedModeBanner: false,
    title: 'TopCalls',
    color: Colors.black,
    initialRoute: "Homepage",
  ));
}
