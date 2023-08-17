import 'package:flutter/material.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
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
      drawer: NavigationDrawer(indicatorColor: Colors.black, children: [
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
            )),
        TextButton(
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("AccountPage", (route) => false);
            },
            child: Row(
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
            ))
      ]),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Text("Sync logs automatically"),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
