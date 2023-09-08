import 'package:flutter/material.dart';
import 'package:topcalls/Frontend/Consts.dart';

AlertDialog show_alert(
    {required BuildContext context,
    required String message,
    required String button}) {
  return AlertDialog(
    title: const Text("TopLogs"),
    content: Text("$message"),
    actions: [
      Container(
          width: screenwidth * 0.15,
          height: 50,
          child: TextButton(
              style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.padded,
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(218, 103, 199, 223))),
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                button,
                style: TextStyle(
                    fontSize: screenwidth * 0.15 / 3, color: Colors.black),
              ))),
    ],
  );
}
