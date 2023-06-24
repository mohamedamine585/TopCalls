import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:topcalls/Call.dart';
import 'package:topcalls/CallsService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  bool checked = false;
  CallsService callsService = CallsService();
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 176, 172, 163),
          actions: [
            Row(
              children: [
                Text("Emergency numbers :"),
                Checkbox(
                    fillColor:
                        MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 1)),
                    value: checked,
                    onChanged: (box) {
                      checked = box!;
                      setState(() {});
                    })
              ],
            ),
          ],
        ),
        drawer: NavigationDrawer(children: [
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
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.today),
                  SizedBox(
                    width: 75,
                  ),
                  Text(
                    "Today's activity",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ))
        ]),
        body: FutureBuilder(
          future: callsService.fetch_top_contact(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (snapshot.data?.isNotEmpty ?? false) {
              int totald;
              List<Contact> data = snapshot.data!
                  .where((element) =>
                      (checked ? (element.contact.length <= 3) : true))
                  .toList();

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  totald = (data.elementAt(index).totalduration);
                  return Container(
                    child: Card(
                      color: (index == 0)
                          ? Colors.amber
                          : Color.fromARGB(255, 226, 216, 216),
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            child: (index == 0)
                                ? Icon(Icons.favorite)
                                : Text("  ${index + 1}"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 120,
                              child: Text(
                                "N: " + (data.elementAt(index).contact),
                                softWrap: true,
                              )),
                          Container(
                            width: 90,
                            child: Text(
                              " total duration : " +
                                  ((totald < 10000)
                                      ? totald.toString()
                                      : (totald / 1000).toInt().toString() +
                                          "k"),
                              softWrap: true,
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              " last call : " +
                                  (data.elementAt(index).lastcall).toString(),
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
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
        ),
      ),
    );
  }
}
