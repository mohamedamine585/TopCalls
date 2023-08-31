import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Modules/Cloud_Contact.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Frontend/Consts.dart';

import '../Backend/Consts.dart';
import '../Backend/Services/FirebaseServiceProvider.dart';

class Savelogs extends StatefulWidget {
  const Savelogs({super.key});

  @override
  State<Savelogs> createState() => _SavelogsState();
}

class _SavelogsState extends State<Savelogs> {
  final user = Authservice().user;
  List<Cloud_Log> data = [];
  bool select_all = false, should_reload = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                SizedBox(
                  width: screenwidth * 0.05,
                ),
                const Text(
                  "New logs",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: screenlength * 0.1,
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenwidth * 0.08,
                        ),
                        Container(
                            width: screenwidth * 0.3,
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.padded,
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(218, 103, 199, 223))),
                                onPressed: () async {
                                  await FirebaseServiceProvider()
                                      .devicesMangementService
                                      .store_cloud_logs(
                                          cloud_logs: data, email: user!.Email);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "CloudLogsPage", (route) => false);
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ))),
                        SizedBox(
                          width: screenwidth * 0.05,
                        ),
                        Container(
                            width: screenwidth * 0.3,
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.padded,
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(118, 182, 228, 240))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ))),
                      ],
                    )),
                Container(
                  width: screenwidth * 0.3,
                  child: Row(
                    children: [
                      const Text("select all"),
                      Checkbox(
                        value: select_all,
                        onChanged: (onChanged) {
                          setState(() {
                            select_all = onChanged!;
                            for (int i = 0; i < data.length; i++) {
                              data[i].is_saved = onChanged;
                            }
                            should_reload = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ),
                Container(
                  height: screenlength * 0.8,
                  child: FutureBuilder(
                      future: (should_reload)
                          ? FirebaseServiceProvider()
                              .devicesMangementService
                              .fetch_new_logs(Email: user!.Email)
                          : null,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 130, 190, 239)),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done ||
                            !should_reload) {
                          if (!snapshot.hasData ||
                              (snapshot.data?.isEmpty ?? true)) {
                            Navigator.pop(context);
                          }

                          data = (should_reload) ? snapshot.data ?? [] : data;
                          should_reload = true;
                          return RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: screenwidth * 0.95,
                                    height: 120,
                                    child: Card(
                                      shadowColor:
                                          (data.elementAt(index).fromdevice ==
                                                  DEVICE_ID)
                                              ? Colors.blue
                                              : const Color.fromARGB(
                                                  255, 194, 33, 243),
                                      elevation: 4,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Contact name :"),
                                                  Text(
                                                    data.elementAt(index).name,
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
                                                  const Text("Contact log :"),
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
                                          SizedBox(
                                            width: screenwidth * 0.001,
                                          ),
                                          Checkbox(
                                              value: data
                                                  .elementAt(index)
                                                  .is_saved,
                                              onChanged: (onChanged) {
                                                setState(() {
                                                  data[index].is_saved =
                                                      onChanged!;
                                                  should_reload = false;
                                                });
                                              })
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
                )
              ],
            ),
          )),
    );
  }
}
