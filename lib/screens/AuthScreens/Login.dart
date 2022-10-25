import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/models/login_model.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/logo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late login_model login;

  String? password;

  String? username;

  bool isLoading = false;

  bool passerror = false;

  bool emailerror = false;

  bool emailok = false;
  bool passok = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login = login_model();
  }

  bool enablebutton = false;
  bool pass_text = true;

  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: _pagebuild(context), inAsyncCall: isLoading, blur: 0.5),
    );
  }

  Widget _pagebuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Logo(),
                Padding(
                  padding: const EdgeInsets.only(top: 81.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In to your Account',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3F4EC4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          // height: 54,
                          color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            validator: (value) {
                              bool emailerror = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);

                              if (!emailerror) {
                                emailok = false;
                                return 'Invalid Email';
                              } else {
                                emailok = true;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (newValue) {
                              username = newValue;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              prefixIconColor: Colors.black,
                              hintText: 'EMAIL',
                              hintStyle: TextStyle(color: Colors.black),
                              fillColor: Color(0xFFEEF0FD),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          // height: 54,
                          color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              bool passValid = value!.length >= 4;
                              if (!passValid) {
                                passok = false;
                                return 'Password too weak';
                              } else {
                                passok = true;
                              }
                            },
                            onChanged: ((newValue) {
                              password = newValue;
                            }),
                            minLines: 1,
                            maxLines: 1,
                            obscureText: pass_text,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              prefixIcon: const Icon(
                                Icons.lock_outline_sharp,
                                color: Colors.black,
                              ),
                              prefixIconColor: Colors.black,
                              suffix: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: IconButton(
                                    onPressed: (() {
                                      setState(() {
                                        pass_text = !pass_text;
                                      });
                                    }),
                                    icon: !pass_text
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Colors.black,
                                          )
                                        : const Icon(Icons.visibility_off)),
                              ),
                              hintText: 'PASSWORD',
                              hintStyle: const TextStyle(color: Colors.black),
                              fillColor: const Color(0xFFEEF0FD),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Your Password',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF586AF5)),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3F4EC4)),
                          onPressed: () {
                            if (!(passok && emailok)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Fix Present Errors')));
                              return;
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              login.email = username;
                              login.password = password;
                              API api = API();
                              // print(login.toJson());
                              api.login_api(login).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value.toJson()['detail'] == null) {
                                  if (value.toJson()['access'] != null) {
                                    Navigator.popAndPushNamed(
                                        context, '/mainpage');
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(value.toJson()['detail'])));
                                }
                              });
                            }
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: const Center(
                                  child: Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              )))),
                      const Padding(
                        padding: EdgeInsets.only(top: 115.0),
                        child: Center(
                            child: Text(
                          "Don't Have an Account?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFF586AF5)),
                                borderRadius:
                                    BorderRadius.circular(8), // <-- Radius
                              ),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/register');
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: const Center(
                                    child: Text(
                                  'Create an Account',
                                  style: TextStyle(
                                      color: Color(0xFF586AF5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate() {
    return true;
  }
}
