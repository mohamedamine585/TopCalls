import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Backend/Services/AuthService.dart';

class AuthDialog extends StatefulWidget {
  AuthDialog({
    super.key,
    required this.authService,
  });
  Authservice authService;
  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
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
    Authservice authService = widget.authService;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    return Scaffold(
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
                      child: TextButton(
                          onPressed: () async {
                            await authService.Login(
                                collectionReference: collectionReference,
                                Email: email.text,
                                password: password.text);

                            if (authService.cloud_user != null) {
                              Navigator.of(context).popAndPushNamed(
                                "Clouddata",
                              );
                            } else {
                              print("Login failed");
                            }
                          },
                          child: const Text("Login"))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            "Register",
                            arguments: authService,
                            (route) => false);
                      },
                      child: const Text("Register"),
                    ),
                  ),
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
