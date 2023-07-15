import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:topcalls/Backend/AuthService.dart';
import 'package:topcalls/Backend/Consts.dart';

class RegisterDialog extends StatefulWidget {
  RegisterDialog({super.key});
  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController cnfpassword;
  late CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    cnfpassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    cnfpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService? authService =
        ModalRoute.of(context)?.settings.arguments as AuthService?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 176, 172, 163),
      ),
      drawer: NavigationDrawer(children: [
        TextButton(
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "Homepage", arguments: authService, (route) => false);
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
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "Clouddata", arguments: authService, (route) => false);
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
            ))
      ]),
      body: Center(
        child: Dialog(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      style: TextStyle(
                        height: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      style: TextStyle(
                        height: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: cnfpassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                      ),
                      obscureText: true,
                      style: TextStyle(
                        height: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 300,
                      child: TextButton(
                          onPressed: () async {
                            String deviceid = DEVICE_ID ?? "";
                            if (password.text == cnfpassword.text) {
                              await authService?.Register(
                                  Email: email.text, password: password.text);
                            }
                            if (authService?.cloud_user != null) {
                              print("dsq");
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "Clouddata",
                                  arguments: authService,
                                  (route) => false);
                            } else {}
                          },
                          child: const Text("Register"))),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                      width: 270,
                      child: Text(
                          "Sync your data in the cloud and never worry about losing your phone numbers again. Securely store and effortlessly retrieve your contacts whenever you need them.")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
