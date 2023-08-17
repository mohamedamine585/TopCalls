import 'package:flutter/material.dart';

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
                height: 150,
              ),
              const Text(
                "Sign in",
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
                  style: const TextStyle(
                    fontSize: 20,
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
                        style: const TextStyle(
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
                width: 350,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  style: const TextStyle(height: 2, fontSize: 20),
                ),
              ),
              SizedBox(
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
                              Color.fromARGB(218, 94, 227, 250))),
                      onPressed: () async {},
                      child: const Text(
                        "Sign in",
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
