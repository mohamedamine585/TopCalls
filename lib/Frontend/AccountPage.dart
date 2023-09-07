import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Frontend/Consts.dart';
import 'package:topcalls/Frontend/NavigationDrawer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                  "Account",
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
              Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  Text(
                    "Info",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  Container(
                    child: Text("${user?.Email}"),
                    width: screenwidth * 0.4,
                  ),
                  TextButton(onPressed: () {}, child: const Text("Confirm")),
                  TextButton(onPressed: () {}, child: const Text("Change")),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.1,
                  ),
                  Text(
                    "Security",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextButton(
                        onPressed: () {
                          Authservice().Logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "Homepage", (route) => false);
                        },
                        child: const Text(
                          "Sign out",
                          style: TextStyle(color: Colors.white),
                        ))),
              )
            ]),
          ),
        ));
  }
}
