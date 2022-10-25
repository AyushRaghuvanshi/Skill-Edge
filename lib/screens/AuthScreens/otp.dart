import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';
import 'package:skilledge/widgets/logo.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.email});
  final email;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32),
              child: Image.asset(
                'assets/otp.png',
                height: 64,
                width: 64,
              ),
            ),
            Text(
              'ENTER OTP',
              style: TextStyle(color: Color(0xFF2A4ECA), fontSize: 34),
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
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F4EC4)),
                  onPressed: () {
                    
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
