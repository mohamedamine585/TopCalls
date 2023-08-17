import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              SizedBox(
                width: 100,
              ),
              Text(
                "Account",
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
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Info",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        child: const Text("foxweb585@gmail.com"),
                        width: 200,
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text("Confirm")),
                      TextButton(onPressed: () {}, child: const Text("Change")),
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Security",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          "medtlili",
                          style: TextStyle(fontFamily: AutofillHints.password),
                        ),
                      ),
                      TextButton(onPressed: () {}, child: const Text("Change"))
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ))),
                  )
                ]);
              }),
        ),
      ),
    );
  }
}
