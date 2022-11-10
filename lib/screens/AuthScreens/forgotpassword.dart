import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:skilledge/models/forgot_pass.dart';
import 'package:skilledge/screens/AuthScreens/otpforgot.dart';
import 'package:skilledge/services/api_services.dart';

import 'package:skilledge/widgets/logo.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  bool emailok = false;
  late forgot_req_model forgot;
  bool isloading = false;
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forgot = forgot_req_model();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: _pagebuild(context), inAsyncCall: isloading, blur: 0.5),
    );
  }

  @override
  Widget _pagebuild(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              'FORGOT PASSWORD',
              style: TextStyle(color: Color(0xFF1D1E21), fontSize: 34),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (newValue) {
                    email = newValue;
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
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D1E21)),
                  onPressed: () {
                    setState(() {
                      isloading = true;
                    });
                    if (emailok) {
                      API api = API();
                      forgot.email = email.trim();
                      api.forgot(forgot).then((value) {
                        setState(() {
                          isloading = false;
                        });
                     
                        if (value.msg == 'user does not exist') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Email is not registered')));
                        }
                        if (value.msg == 'check mail for otp') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotOTP(
                                      email: email.trim(),
                                    )),
                          );
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Fix Present Errors')));
                    }
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: const Center(
                          child: Text(
                        'Send OTP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )))),
            ),
          ],
        ),
      ),
    );
  }
}
