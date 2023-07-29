import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

TextEditingController email = TextEditingController();
void share_dialog({required Cloud_Log log, required BuildContext context}) {
  email = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => Dialog(
        child: Scaffold(
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Container(
          width: 280,
          child: TextField(
            controller: email,
            decoration: InputDecoration(hintText: "email"),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Container(
              width: 160,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () async {
                    if (email.text != "") {
                      await FirebaseServiceProvider()
                          .logsmangementservice
                          .share_it_with(log: log, email: email.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 160,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 230, 225, 225))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                  )),
            )
          ],
        )
      ]),
    )),
  );
}
