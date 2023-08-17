import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:topcalls/Backend/Consts.dart';

import '../Backend/Services/AuthService.dart';

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
    Authservice? authService =
        ModalRoute.of(context)?.settings.arguments as Authservice?;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 33,
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
                width: 350,
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
              const Row(
                children: [
                  const SizedBox(
                    width: 33,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(fontSize: 18),
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
                width: 350,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  style: TextStyle(
                    height: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  const SizedBox(
                    width: 33,
                  ),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 18),
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
                width: 350,
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
                  width: 300,
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
                        String deviceid = DEVICE_ID ?? "";
                        if (password.text == cnfpassword.text) {
                          await authService?.Register(
                              Email: email.text, password: password.text);
                        }
                        if (authService?.cloud_user != null) {
                          print("dsq");
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "Clouddata", (route) => false);
                        } else {}
                      },
                      child: const Text(
                        "Get Saved",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ))),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 300,
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
                height: 70,
              ),
              Container(
                  width: 270,
                  child: Text(
                      "Sync your data in the cloud and never worry about losing your logs again. Securely store and effortlessly retrieve your logs whenever you need them.")),
            ],
          ),
        ),
      ),
    );
  }
}
