import 'package:flutter/material.dart';
import 'package:topcalls/Frontend/AccountPage.dart';
import 'package:topcalls/Frontend/AuthenticationDialog.dart';
import 'package:topcalls/Frontend/CloudLogs.dart';
import 'package:topcalls/Frontend/Configuration.dart';
import 'package:topcalls/Frontend/Homepage.dart';
import 'package:topcalls/Frontend/RegisterDialog.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      "ConfigurationPage": (context) => const Configuration(),
      "AccountPage": (context) => const AccountPage(),
      "CloudLogsPage": (context) => const CloudLogsPage(), // to hold the place
      "Signin": (context) => const SigninPage(),
      "Homepage": (context) => const Homepage(),
      "Register": (context) => const RegisterPage(),
    },
    debugShowCheckedModeBanner: false,
    title: 'TopCalls',
    color: Colors.black,
    initialRoute: "Homepage",
  ));
}
