import 'package:flutter/material.dart';

Widget navigationdrawer({required BuildContext context}) {
  return NavigationDrawer(indicatorColor: Colors.black, children: [
    TextButton(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("CloudLogsPage", (route) => false);
        },
        child: const Row(
          children: [
            Icon(Icons.home),
            SizedBox(
              width: 75,
            ),
            Text(
              "Home",
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
    TextButton(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("AccountPage", (route) => false);
        },
        child: const Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 75,
            ),
            Text(
              "Account",
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
    TextButton(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("ConfigurationPage", (route) => false);
        },
        child: const Row(
          children: [
            Icon(Icons.settings),
            SizedBox(
              width: 75,
            ),
            Text(
              "Configuration",
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
  ]);
}
