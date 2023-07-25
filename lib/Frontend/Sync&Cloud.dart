import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:topcalls/Backend/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Frontend/AuthenticationDialog.dart';

import '../Backend/Services/AuthService.dart';

class CloudContacts extends StatefulWidget {
  const CloudContacts({super.key});

  @override
  State<CloudContacts> createState() => _CloudContactsState();
}

class _CloudContactsState extends State<CloudContacts> {
  @override
  Widget build(BuildContext context) {
    Authservice authService = Authservice();

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: const Text(
              "Cloud Logs",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 176, 172, 163),
          actions: [
            (authService.cloud_user != null)
                ? IconButton(
                    onPressed: () async {
                      await authService.Logout();
                      authService.cloud_user = null;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "Clouddata", (route) => false);
                    },
                    icon: const Icon(Icons.logout))
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
        backgroundColor: Color.fromARGB(255, 234, 233, 233),
        body: (authService.cloud_user != null)
            ? FutureBuilder(
                future: FirebaseServiceProvider()
                    .devicesMangementService
                    .load_cloud_logs(
                        Email: authService.cloud_user?.Email ?? ""),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Cloud_Log>> snapshot) {
                  if (snapshot.data?.isNotEmpty ?? false) {
                    int totald;
                    List<Cloud_Log> data = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 70,
                            child: Card(
                              color: (data.elementAt(index).fromdevice ==
                                      DEVICE_ID)
                                  ? Color.fromARGB(255, 99, 229, 244)
                                  : Color.fromARGB(255, 235, 107, 226),
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "number :" + data.elementAt(index).number,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                        "name :" + data.elementAt(index).name),
                                  ),
                                  Container(
                                    width: 250,
                                    child: Text("from device :" +
                                        data.elementAt(index).fromdevice),
                                  ),
                                ],
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
