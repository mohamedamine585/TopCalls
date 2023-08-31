import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Modules/Cloud_Contact.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Frontend/Dialogs.dart';

import 'NavigationDrawer.dart';

class CloudLogsPage extends StatefulWidget {
  const CloudLogsPage({super.key});

  @override
  State<CloudLogsPage> createState() => _CloudLogsPageState();
}

class _CloudLogsPageState extends State<CloudLogsPage> {
  late final TextEditingController filter;
  final user = Authservice().user;
  @override
  void initState() {
    filter = TextEditingController();

    super.initState();

    Future.delayed(Duration.zero, () async {
      final new_data = await FirebaseServiceProvider()
          .devicesMangementService
          .fetch_new_logs(Email: user!.Email);
      if (new_data.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => const Savelogs(),
        );
      }
    });
  }

  List<Cloud_Log> data = [];
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenlength = MediaQuery.of(context).size.height;

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
      drawer: navigationdrawer(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                width: screenwidth * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      filter.text = query;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
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
              width: screenwidth * 0.9,
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: screenwidth * 0.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                  ),
                  SizedBox(
                    width: screenwidth * 0.005,
                  ),
                  Text("from this device"),
                  SizedBox(
                    width: screenwidth * 0.001,
                  ),
                  Container(
                    height: 15,
                    width: screenwidth * 0.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 194, 33, 243)),
                  ),
                  SizedBox(
                    width: screenwidth * 0.005,
                  ),
                  Text(
                    "from another device",
                    softWrap: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              height: screenlength * 0.63,
              child: FutureBuilder(
                  future: FirebaseServiceProvider()
                      .devicesMangementService
                      .load_cloud_logs(Email: user!.Email),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 130, 190, 239)),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            Text(
                              "No data",
                              style: TextStyle(fontSize: 40),
                            ),
                          ],
                        );
                      }
                      data = snapshot.data
                              ?.where((element) =>
                                  element.name.contains(filter.text) ||
                                  element.number.contains(filter.text))
                              .toList() ??
                          [];
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: screenwidth * 0.95,
                                height: 120,
                                child: Card(
                                  shadowColor: (data
                                              .elementAt(index)
                                              .fromdevice ==
                                          DEVICE_ID)
                                      ? Colors.blue
                                      : const Color.fromARGB(255, 194, 33, 243),
                                  elevation: 4,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenwidth * 0.6,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: screenwidth * 0.95,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text("Contact name :"),
                                                  Text(
                                                      data
                                                          .elementAt(index)
                                                          .name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: screenwidth * 0.95,
                                              child: Row(
                                                children: [
                                                  Text("Contact log :"),
                                                  Text(
                                                    data
                                                        .elementAt(index)
                                                        .number,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
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
                                            ),
                                            Row(
                                              children: [
                                                Text("From device :"),
                                                Text(
                                                  data
                                                      .elementAt(index)
                                                      .fromdevice,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.01,
                                      ),
                                      Container(
                                        width: screenwidth * 0.3,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenwidth * 0.1,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.phone,
                                                    size: screenwidth * 0.05,
                                                  )),
                                            ),
                                            Container(
                                              width: screenwidth * 0.1,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.share,
                                                    size: screenwidth * 0.05,
                                                  )),
                                            ),
                                            Container(
                                              width: screenwidth * 0.1,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: screenwidth * 0.05,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ));
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
    );
  }
}
