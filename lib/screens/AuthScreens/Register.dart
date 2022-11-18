import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:skilledge/models/reg_model.dart';

import 'package:skilledge/screens/AuthScreens/otp.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/logo.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.edu});
  final edu;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? name;
  String? username;
  String? email;
  String? pass;
  String? pass2check;

  bool fullname = false;
  bool user = false;
  bool mail = false;
  bool pass1 = false;
  bool pass2 = false;

  bool pass_text = true;

  late reg_req_model register;

  @override
  void initState() {
    super.initState();
    register = reg_req_model();
  }

  bool isLoading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: _regpagebuild(context), inAsyncCall: isLoading, blur: 0.5),
    );
  }

  Widget _regpagebuild(BuildContext context) {
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
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create your Account',
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
                            onChanged: (value) {
                              name = value;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length == 0) {
                                fullname = false;
                                return 'Enter Your Name';
                              } else {
                                fullname = true;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_box_outlined,
                                color: Colors.black,
                              ),
                              prefixIconColor: Colors.black,
                              hintText: 'FULL NAME',
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
                          // color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            minLines: 1,
                            maxLength: 100,
                            maxLines: 1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length == 0) {
                                user = false;
                                return 'Enter Your Username';
                              } else {
                                user = true;
                              }
                              return null;
                            },
                            onChanged: ((value) {
                              username = value;
                            }),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_box_outlined,
                                color: Colors.black,
                              ),
                              prefixIconColor: Colors.black,
                              hintText: 'USERNAME',
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
                          // color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              bool emailerror = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);

                              if (!emailerror) {
                                mail = false;
                                return 'Invalid Email';
                              } else {
                                mail = true;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                            },
                            minLines: 1,
                            maxLength: 100,
                            maxLines: 1,
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
                          // color: const Color(0xFFEEF0FD),
                          child: TextFormField(
                            minLines: 1,
                            maxLength: 100,
                            maxLines: 1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              bool passValid = RegExp(
                                      r"^(?=(.*[a-z]){1,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){1,})(?=(.*[!@#$%^&*()\-__+.]){1,}).{8,}$")
                                  .hasMatch(value!);
                              if (!passValid) {
                                pass1 = false;
                                return 'Password needs to be more than 8 characters, \ncontains at least 1 uppercase , 1 lowercase, 1 number and \n1 special character';
                              } else {
                                pass1 = true;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                pass = value;
                              });
                            },
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
                              if (pass != pass2check) {
                                pass2 = false;
                                return 'Passwords dont match';
                              } else {
                                pass2 = true;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                pass2check = value;
                              });
                            },
                            obscureText: pass_text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
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
                              hintText: 'REPEAT PASSWORD',
                              hintStyle: const TextStyle(color: Colors.black),
                              fillColor: const Color(0xFFEEF0FD),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF01C5A6)),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (fullname && mail && user && pass1 && pass2) {
                                register.email = email;
                                register.name = name;
                                register.confirmPassword = pass2check;
                                register.password = pass;
                                register.userName = username;
                                API api = API();
                                api.reg_api(register).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (value.msg == "Email") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'This Email is already in use, Try Signing up.')));
                                  } else if (value.msg == "Username") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'This Username is not avaiable.')));
                                  }
                                  if (value.msg == "success") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OtpScreen(
                                                edu: widget.edu,
                                                name: register.name,
                                                email: register.email,
                                                username: register.userName,
                                              )),
                                    );
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Please Vaidate All Entered Fields')));
                                return;
                              }
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: const Center(
                                    child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )))),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: Text(
                          "Already have an Account?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFF01C5A6)),
                                borderRadius:
                                    BorderRadius.circular(8), // <-- Radius
                              ),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/login');
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: const Center(
                                    child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Color(0xFF01C5A6),
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
