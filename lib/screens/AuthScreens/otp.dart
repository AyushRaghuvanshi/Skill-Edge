import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:skilledge/models/otp_model.dart';
import 'package:skilledge/models/resendotp.dart';
import 'package:skilledge/screens/OnboardingUI/onBordingQnA.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/logo.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.email, this.name, this.username, this.edu});
  final email;
  final edu;
  final name;
  final username;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late OTP_req_model otp_req;
  late resendotp_req_model resend;
  String otp = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    otp_req = OTP_req_model();
    resend = resendotp_req_model();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: isLoading, child: _otpbuild(context));
  }

  Widget _otpbuild(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
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
                    style: TextStyle(color: Color(0xFF01C5A6), fontSize: 34),
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
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          API api = API();
                          resend.email = widget.email;
                          api.resendotp(resend).then((value) {
                            setState(() {
                              isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value.msg.toString())));
                          });
                        },
                        child: Text('Resend OTP')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF01C5A6)),
                        onPressed: () {
                          if (otp.toString().length != 4) {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          otp_req.email = widget.email;
                          otp_req.otp = otp;
                          API api = API();
                          api.verifyotp(otp_req).then((value) {
                            setState(() {
                              isLoading = false;
                            });

                            if (value.msg == 'otp is not valid') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Incorrect OTP')));
                            }
                            if (value.msg == 'OTP expired') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('OTP Expired, kindly Resend')));
                            }
                            if (value.msg == 'verification Successfull') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnboardingQA(
                                          edu: widget.edu,
                                          fullName: widget.name,
                                          email: widget.email,
                                          userName: widget.username,
                                        )),
                              );
                            }
                          });
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: const Center(
                                child: Text(
                              'Verify OTP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            )))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
