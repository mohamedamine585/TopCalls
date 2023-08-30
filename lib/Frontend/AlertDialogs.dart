import 'package:flutter/material.dart';
import 'package:topcalls/Frontend/Consts.dart';

AlertDialog show_alert(
    {required BuildContext context, required String message}) {
  return AlertDialog(
    title: const Text("TopLogs"),
    content: Text("$message"),
    actions: [
      Container(
          width: screenwidth * 0.1,
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
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ))),
    ],
  );
}
