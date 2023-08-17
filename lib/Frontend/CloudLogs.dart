import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Cloud_user.dart';
import 'package:topcalls/Backend/Contact.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/LogService.dart';

import '../Backend/Services/FirebaseServiceProvider.dart';

class CloudLogsPage extends StatefulWidget {
  const CloudLogsPage({super.key});

  @override
  State<CloudLogsPage> createState() => _CloudLogsPageState();
}

class _CloudLogsPageState extends State<CloudLogsPage> {
  late final TextEditingController filter;
  @override
  void initState() {
    filter = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Row(
            children: [
              const SizedBox(
                width: 90,
              ),
              const Text(
                "Top Logs",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        drawer: NavigationDrawer(indicatorColor: Colors.black, children: [
          TextButton(
              style: ButtonStyle(
                iconColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Homepage", (route) => false);
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
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Clouddata", (route) => false);
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
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: const TextField(
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Filter by number or name",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        prefixIcon: Icon(Icons.search),
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 280,
                  child: Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("from this device"),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 194, 33, 243)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("from another device"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  height: 700,
                  child: FutureBuilder(
                      future: null,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 130, 190, 239)),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.none) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                height: 100,
                                child: Card(
                                  elevation: 4,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("Contact name :"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [Text("Contact log :")],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("Total call duration :")
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("Last call :"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "No data",
                              style: TextStyle(fontSize: 40),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
