import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Consts.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

import 'NavigationDrawer.dart';

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
    final user = Authservice().cloud_user;
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
                    width: screenwidth * 0.9,
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
                  width: screenwidth * 0.7,
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
                  height: screenlength * 0.75,
                  child: FutureBuilder(
                      future: FirebaseServiceProvider()
                          .devicesMangementService
                          .load_cloud_logs(Email: user!.Email),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data;
                              return Container(
                                width: 150,
                                height: 120,
                                child: Card(
                                  shadowColor: (data!
                                              .elementAt(index)
                                              .fromdevice ==
                                          DEVICE_ID)
                                      ? Colors.blue
                                      : const Color.fromARGB(255, 194, 33, 243),
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
                                              Text(
                                                data!.elementAt(index).name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text("Contact log :"),
                                              Text(
                                                data.elementAt(index).number,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
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
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.phone)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.share)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.list_alt_rounded))
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
