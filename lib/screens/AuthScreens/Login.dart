import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/models/login_model.dart';
import 'package:skilledge/screens/AuthScreens/forgotpassword.dart';
import 'package:skilledge/screens/dashboard.dart';
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
                            color: Color(0xFF1D1E21)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          // height: 54,
                          // color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            minLines: 1,
                            maxLength: 100,
                            maxLines: 1,
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
                              hintText: 'EMAIL',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          // height: 54,
                          // color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            minLines: 1,
                            maxLength: 100,
                            maxLines: 1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              bool passValid = value!.length >= 4;
                              if (!passValid) {
                                passok = false;
                                return 'Password need to be of more than 4 charactors';
                              } else {
                                passok = true;
                                return null;
                              }
                            },
                            onChanged: ((newValue) {
                              password = newValue;
                            }),
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
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPass()),
                          );
                        },
                        child: const Text(
                          'Forgot Your Password',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF1D1E21)),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D1E21)),
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

                              login.email = username!.trim().toLowerCase();
                              login.password = password!.trim();
                              API api = API();
                              // print(login.toJson());
                              api.login_api(login).then((value) async {
                                setState(() {
                                  isLoading = false;
                                });

                                if (value.toJson()['token'] != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Dashboard())));
                                } else {
                                  print(value.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(value.toJson()['msg'])));
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
                                side: BorderSide(color: Color(0xFF1D1E21)),
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
                                      color: Color(0xFF1D1E21),
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
}
