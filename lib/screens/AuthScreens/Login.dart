import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  var rightpass =
      " /^(?=.[a-z])(?=.[A-Z])(?=.\\d)(?=.[@\$!%?&#])[A-Za-z\d@\$!%?&#]{8,}\$/";

  bool emailok = false;
  bool passok = false;
  @override
  void initState() {
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
                              return null;
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
                              bool passValid = RegExp(
                                      r"^(?=(.*[a-z]){1,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){1,})(?=(.*[!@#$%^&*()\-__+.]){1,}).{8,}$")
                                  .hasMatch(value!);

                              if (!passValid) {
                                passok = false;
                                return 'Password needs to be more than 8 characters, \ncontains at least 1 uppercase , 1 lowercase, 1 number and \n1 special character';
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
                              backgroundColor: const Color(0xFF01C5A6)),
                          onPressed: () {
                            if (!(passok && emailok)) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Please validate All Entered Fields')));
                              return;
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              login.email = username!.trim().toLowerCase();
                              login.password = password!.trim();
                              API api = API();

                              api.login_api(login).then((value) async {
                                setState(() {
                                  isLoading = false;
                                });

                                if (value.toJson()['token'] != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Dashboard())),
                                      (route) => false);
                                } else {
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
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
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
                                side: BorderSide(color: Color(0xFF01C5A6)),
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
                                  'Sign Up',
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
