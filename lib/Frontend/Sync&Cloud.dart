import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:topcalls/Backend/AuthService.dart';

import 'package:topcalls/Backend/FirebaseServiceProvider.dart';
import 'package:topcalls/Frontend/AuthenticationDialog.dart';

import '../Backend/Contact.dart';
import '../OldBackend/OldFirebaseService.dart';

class CloudContacts extends StatefulWidget {
  const CloudContacts({super.key});

  @override
  State<CloudContacts> createState() => _CloudContactsState();
}

class _CloudContactsState extends State<CloudContacts> {
  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    AuthService authService =
        ModalRoute.of(context)?.settings.arguments as AuthService;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 176, 172, 163),
          actions: [
            (authService.cloud_user != null)
                ? TextButton(
                    onPressed: () async {
                      await authService.Logout();
                      authService.cloud_user = null;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "Clouddata",
                          arguments: authService,
                          (route) => false);
                    },
                    child: const Text("Logout"))
                : SizedBox()
          ],
        ),
        drawer: NavigationDrawer(children: [
          TextButton(
              style: ButtonStyle(
                iconColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "Homepage", arguments: authService, (route) => false);
              },
              child: Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(
                    width: 100,
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "Clouddata", arguments: authService, (route) => false);
              },
              child: Row(
                children: [
                  Icon(Icons.cloud),
                  SizedBox(
                    width: 75,
                  ),
                  Text(
                    "Cloud data",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ))
        ]),
        backgroundColor: Color.fromARGB(255, 176, 172, 163),
        body: (authService.cloud_user != null)
            ? FutureBuilder(
                future: FirebaseServiceProvider()
                    .Load_data(Email: authService.cloud_user?.Email ?? ""),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.data?.isNotEmpty ?? false) {
                    int totald;
                    List<String> data = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 50,
                            child: Card(
                              child: Text(
                                data.elementAt(index),
                                style: TextStyle(fontSize: 20),
                              ),
                            ));
                      },
                    );
                  } else {
                    return RefreshIndicator(
                        onRefresh: () async {
                          setState(() {});
                        },
                        child: Center(
                          child: Text(
                            "No data found ",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ));
                  }
                },
              )
            : AuthDialog(
                authService: authService,
              ));
  }
}
