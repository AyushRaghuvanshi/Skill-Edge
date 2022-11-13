import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:skilledge/models/forgot_pass.dart';
import 'package:skilledge/models/newpass.dart';
import 'package:skilledge/models/otp_model.dart';
import 'package:skilledge/models/resendotp.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/logo.dart';

class ForgotOTP extends StatefulWidget {
  const ForgotOTP({super.key, this.email});
  final email;
  @override
  State<ForgotOTP> createState() => _ForgotOTPState();
}

class _ForgotOTPState extends State<ForgotOTP> {
  late newpass_req_model otp_req;
  late forgot_req_model resend;
  String otp = '';
  bool isLoading = false;

  bool pass_text = false;

  String pass = "";

  bool pass1 = false;

  String pass2check = "";

  bool pass2 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otp_req = newpass_req_model();
    resend = forgot_req_model();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: isLoading, child: _otpbuild(context));
  }

  Widget _otpbuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo(),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 32),
                  child: Image.asset(
                    'assets/otp.png',
                    height: 64,
                    width: 64,
                  ),
                ),
                const Text(
                  'ENTER OTP',
                  style: TextStyle(color: Color(0xFF1D1E21), fontSize: 34),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Pinput(
                    length: 4,
                    onChanged: (value) {
                      otp = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              API api = API();
                              resend.email = widget.email;
                              api.forgot(resend).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(value.msg.toString())));
                              });
                            },
                            child: Text('Resend OTP')),
                      ),
                    ],
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (pass != pass2check) {
                          pass2 = false;
                          return 'Passwords dont match';
                        } else {
                          pass2 = true;
                        }
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
                  padding: const EdgeInsets.only(top: 24.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF01C5A6)),
                      onPressed: () {
                        if (pass1 && pass2 && otp.toString().length > 0) {
                          setState(() {
                            isLoading = true;
                          });
                          API api = API();
                          otp_req.email = widget.email;
                          otp_req.confirmPasswordd = pass;
                          otp_req.passwordd = pass2check;
                          otp_req.otp = otp;
                          api.newpass(otp_req).then((value) {
                            setState(() {
                              isLoading = false;
                            });

                            if (value.msg == 'otp is not valid') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Invalid OTP')));
                            } else if (value.msg == 'reset Successfull') {
                              Navigator.popAndPushNamed(context, '/login');
                            } else if (value.msg != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(value.msg.toString())));
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please Validate All Entered Fields')));
                        }
                      },
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: const Center(
                              child: Text(
                            'Verify OTP',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          )))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
