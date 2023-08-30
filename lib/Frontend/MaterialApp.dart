import 'package:flutter/material.dart';

import 'AccountPage.dart';
import 'AuthenticationDialog.dart';
import 'CloudLogs.dart';
import 'Configuration.dart';
import 'Homepage.dart';
import 'RegisterDialog.dart';

MaterialApp get app => MaterialApp(
      routes: {
        "ConfigurationPage": (context) => const Configuration(),
        "AccountPage": (context) => const AccountPage(),
        "CloudLogsPage": (context) => const CloudLogsPage(),
        "Signin": (context) => const SigninPage(),
        "Homepage": (context) => const Homepage(),
        "Register": (context) => const RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'TopCalls',
      color: Colors.black,
      initialRoute: "Homepage",
    );
