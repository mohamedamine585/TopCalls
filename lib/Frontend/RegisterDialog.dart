import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Services/FirebaseServiceProvider.dart';

import '../Backend/Services/AuthService.dart';
import 'AlertDialogs.dart';
import 'Consts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenlength / 10,
              ),
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenlength * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 7,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: screenwidth * 0.7,
                height: screenlength * 0.1,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: email,
                  style: TextStyle(
                    height: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 7,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.7,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  style: const TextStyle(
                    height: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth / 7,
                  ),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: screenwidth * 0.7,
                child: TextField(
                  controller: cnfpassword,
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
                              Color.fromARGB(218, 94, 227, 250))),
                      onPressed: () async {
                        if (await FirebaseServiceProvider()
                            .systemmangementprovider
                            .check_connection()) {
                          final authservice = Authservice();
                          if (password.text == cnfpassword.text) {
                            if (emailRegExp.hasMatch(email.text)) {
                              if (password.text.length >= 8) {
                                await authservice.Register(
                                    Email: email.text, password: password.text);

                                if (authservice.user != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "CloudLogsPage", (route) => false);
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => show_alert(
                                        context: context,
                                        message: "The password is too short",
                                        button: "Ok"));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => show_alert(
                                      context: context,
                                      message: "The email is no valid",
                                      button: "Ok"));
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => show_alert(
                                  context: context,
                                  message: "Passwords don't match",
                                  button: "Ok"),
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => show_alert(
                                context: context,
                                message: "Check your internet connection",
                                button: "Ok"),
                          );
                        }
                      },
                      child: const Text(
                        "Get Saved",
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
                            "Signin", (route) => false);
                      },
                      child: const Text(
                        "I'm already in",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ))),
              SizedBox(
                height: screenlength * 0.05,
              ),
              Container(
                  width: screenwidth * 0.7,
                  height: screenlength * 0.1,
                  child: Text(
                      "Sync your logs in the cloud and never worry about losing them again. Securely store and effortlessly retrieve your logs whenever you need them.")),
            ],
          ),
        ),
      ),
    );
  }

  RegExp emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );
}
