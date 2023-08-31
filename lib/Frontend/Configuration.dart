import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';
import 'package:topcalls/Frontend/Consts.dart';

import 'NavigationDrawer.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  bool instart1 = false, instart2 = false, instart3 = false;

  SlidableButtonPosition ipos1 = SlidableButtonPosition.start,
      ipos2 = SlidableButtonPosition.start,
      ipos3 = SlidableButtonPosition.start;
  @override
  void initState() {
    super.initState();
  }

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
              width: screenwidth * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenwidth * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenwidth * 0.005),
                    child: Container(
                      width: screenwidth * 0.5,
                      child: const Text(
                        "Sync logs automatically",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  HorizontalSlidableButton(
                    onChanged: (position) {
                      FirebaseServiceProvider()
                          .systemmangementprovider
                          .sync_logs_automatically(
                              sync: (position.index == 0) ? false : true);
                      setState(() {
                        instart1 = !instart1;
                      });
                    },
                    width: screenwidth * 0.15,
                    height: screenlength * 0.035,
                    color: (instart1)
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
                        children: ([
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
                  Padding(
                    padding: EdgeInsets.only(left: screenwidth * 0.005),
                    child: Container(
                      width: screenwidth * 0.5,
                      child: const Text(
                        "Receive notifications",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  HorizontalSlidableButton(
                    onChanged: (position) {
                      setState(() {
                        instart2 = !instart2;
                      });
                    },
                    width: screenwidth * 0.15,
                    height: screenlength * 0.035,
                    color: (instart2)
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ([
                        SizedBox(
                          width: screenwidth * 0.05,
                        ),
                        const Text('Off'),
                      ]),
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
                  Padding(
                    padding: EdgeInsets.only(left: screenwidth * 0.05),
                    child: Padding(
                      padding: EdgeInsets.only(left: screenwidth * 0.005),
                      child: Container(
                        width: screenwidth * 0.5,
                        child: const Text(
                          "Stay connected",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  HorizontalSlidableButton(
                    onChanged: (position) {
                      FirebaseServiceProvider()
                          .systemmangementprovider
                          .stay_signed_in(
                              stay: (position.index == 0) ? false : true);
                      setState(() {
                        instart3 = !instart3;
                      });
                    },
                    width: screenwidth * 0.15,
                    height: screenlength * 0.035,
                    color: (instart3)
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
                        children: ([
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
