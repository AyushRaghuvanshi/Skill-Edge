import 'package:flutter/material.dart';
import 'package:skilledge/screens/AuthScreens/Login.dart';
import 'package:skilledge/widgets/logo.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logo(),
                Padding(
                  padding: const EdgeInsets.only(top: 108.0),
                  child: Image.asset('assets/Signimg.png'),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3F4EC4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Container(
                      width: 266,
                      height: 45,
                      child: Center(child: Text('Sign In As An Educator')),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF586AF5)),
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Container(
                        width: 266,
                        height: 45,
                        child: Center(
                            child: Text(
                          'Sign In As An Student',
                          style: TextStyle(color: Color(0xFF586AF5)),
                        )),
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
