import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:topcalls/Frontend/Consts.dart';

import 'NavigationDrawer.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  bool instart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Text(
                "Configurations",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      drawer: navigationdrawer(context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              width: screenwidth * 0.99,
              child: Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  const Text(
                    "Sync logs automatically",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: screenwidth * 0.2,
                  ),
                  HorizontalSlidableButton(
                    onChanged: (position) {
                      setState(() {
                        instart = !instart;
                      });
                    },
                    width: screenwidth * 0.2,
                    height: screenlength * 0.035,
                    color: (instart)
                        ? Color.fromARGB(255, 148, 241, 241)
                        : Color.fromARGB(255, 199, 62, 202),
                    label: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    buttonWidth: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: (instart)
                            ? ([
                                const Text('On'),
                              ])
                            : ([
                                SizedBox(
                                  width: screenwidth * 0.05,
                                ),
                                const Text('Off'),
                              ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: screenwidth * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenwidth * 0.05,
                  ),
                  const Text(
                    "Receive notifications",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: screenwidth * 0.2,
                  ),
                  HorizontalSlidableButton(
                    onChanged: (position) {
                      setState(() {
                        instart = !instart;
                      });
                    },
                    width: screenwidth * 0.2,
                    height: screenlength * 0.035,
                    color: (instart)
                        ? Color.fromARGB(255, 148, 241, 241)
                        : Color.fromARGB(255, 199, 62, 202),
                    label: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    buttonWidth: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: (instart)
                            ? ([
                                const Text('On'),
                              ])
                            : ([
                                SizedBox(
                                  width: screenwidth * 0.05,
                                ),
                                const Text('Off'),
                              ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: screenwidth * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenwidth * 0.001,
                  ),
                  const Text(
                    "Stay connected",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: screenwidth * 0.2,
                  ),
                  HorizontalSlidableButton(
                    onChanged: (position) {
                      setState(() {
                        instart = !instart;
                      });
                    },
                    width: screenwidth * 0.2,
                    height: screenlength * 0.035,
                    color: (instart)
                        ? Color.fromARGB(255, 148, 241, 241)
                        : Color.fromARGB(255, 199, 62, 202),
                    label: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    buttonWidth: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: (instart)
                            ? ([
                                const Text('On'),
                              ])
                            : ([
                                SizedBox(
                                  width: screenwidth * 0.05,
                                ),
                                const Text('Off'),
                              ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
