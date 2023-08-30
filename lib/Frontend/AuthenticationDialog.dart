import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Services/AuthService.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

import 'AlertDialogs.dart';
import 'Consts.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({
    super.key,
  });
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenlength / 6,
              ),
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenlength / 13,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  Column(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: screenwidth * 0.86,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: email,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 2,
                  ),
                ),
              ),
              SizedBox(
                height: screenlength / 70,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 13,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.86,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  style: const TextStyle(height: 2, fontSize: 20),
                ),
              ),
              SizedBox(
                height: screenlength / 20,
              ),
              Container(
                  width: screenwidth * 0.70,
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.padded,
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(218, 94, 227, 250))),
                      onPressed: () async {
                        if (await FirebaseServiceProvider()
                            .systemmangementprovider
                            .check_connection()) {
                          await Authservice().Login(
                              collectionReference:
                                  FirebaseServiceProvider().userscollection,
                              Email: email.text,
                              password: password.text);
                          final user = Authservice().cloud_user;

                          if (user != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "CloudLogsPage", (route) => false);
                          } else {
                            print(user);
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => show_alert(
                                context: context,
                                message: "Check your internet connection"),
                          );
                        }
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ))),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.padded,
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(218, 182, 228, 240))),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "Register", (route) => false);
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ))),
              SizedBox(
                height: 70,
              ),
              Container(
                  height: screenlength * 0.1,
                  width: screenwidth * 0.7,
                  child: Text(
                      "Sync your logs in the cloud and never worry about losing them again. Securely store and effortlessly retrieve your logs whenever you need them.")),
            ],
          ),
        ),
      ),
    );
  }
}
