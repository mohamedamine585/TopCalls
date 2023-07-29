import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:topcalls/Frontend/Home.dart';
import 'package:topcalls/Frontend/RegisterDialog.dart';
import 'package:topcalls/Frontend/Sync&Cloud.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      "Homepage": (context) => const Home(),
      "Clouddata": (context) => const CloudContacts(),
      "Register": (context) => RegisterDialog(),
    },
    debugShowCheckedModeBanner: false,
    title: 'TopCalls',
    color: Colors.black,
    initialRoute: "Homepage",
  ));
}
