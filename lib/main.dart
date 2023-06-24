import 'package:flutter/material.dart';
import 'package:topcalls/Home.dart';

void main() async {
  runApp(MaterialApp(
    routes: {
      "Homepage": (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
    title: 'TopCalls',
    color: Colors.black,
    home: Home(),
  ));
}
