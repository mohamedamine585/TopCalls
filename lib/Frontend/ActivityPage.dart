import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Frontend/Consts.dart';
import 'package:topcalls/Frontend/NavigationDrawer.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    final user = Authservice().user;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                SizedBox(
                  width: screenwidth * 0.22,
                ),
                const Text(
                  "Activity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
        drawer: navigationdrawer(context: context),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Logs",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.01,
                  ),
                  Container(
                    width: screenwidth * 0.3,
                    child: Column(
                      children: [
                        Text(
                          "Saved Logs",
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("145"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.01,
                  ),
                  Container(
                    width: screenwidth * 0.35,
                    child: Column(
                      children: [
                        Text(
                          "Black List Logs",
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("145"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.01,
                  ),
                  Container(
                    width: screenwidth * 0.3,
                    child: Column(
                      children: [
                        Text(
                          "unsaved Logs",
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("145"),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Top 10 Logs called",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: screenlength * 0.1,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: screenwidth * 0.3,
                      child: ListTile(
                        title: Text("text"),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
