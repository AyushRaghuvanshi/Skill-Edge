import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WalletEdu extends StatefulWidget {
  const WalletEdu({super.key});

  @override
  State<WalletEdu> createState() => _WalletEduState();
}

class _WalletEduState extends State<WalletEdu> {
  int addamount = 0;
  int amount = 0;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(color: Color(0xFF01C5A6)),
                    ),
                  ),
                  Positioned(
                    bottom: -70,
                    child: Container(
                        padding: EdgeInsets.all(24),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 160,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'SkillEdge ',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    'Wallet',
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF01C5A6)),
                                  )
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    '\$$amount',
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFF01C5A6)),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Current Balance',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ]),
                        decoration: BoxDecoration(
                            color: Color(0xFFF6FAFA),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFF01C5A6)),
                  onPressed: () => _showpopup(context),
                  child: Text(
                    'Redeem Balance',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }

  _showpopup(context) {
    Alert(
        context: context,
        title: "Redeem Balance",
        content: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                addamount = int.parse(value);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.money),
                labelText: '\$1000',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Color(0xFF01C5A6),
            splashColor: Color(0xFF01C5A6),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Redeem Balance",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}