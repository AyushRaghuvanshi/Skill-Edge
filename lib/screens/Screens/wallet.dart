import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skilledge/screens/PaymentScreens/check.dart';
import 'package:skilledge/services/api_services.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key, this.amount});
  final amount;

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String addamount = "0";
  double amount = -1.0;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  double wallet_money = 0;

  void _onRefresh() async {
    // monitor network fetch
    API api = new API();
    wallet_money = await api.getwalletmoney();

    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wallet_money = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
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
                                          fontSize: 24,
                                          color: Color(0xFF01C5A6)),
                                    )
                                  ],
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      '₹${(wallet_money).floor()}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Color(0xFF01C5A6)),
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
                padding: const EdgeInsets.only(top: 84.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF01C5A6)),
                    onPressed: () => _showpopup(context),
                    child: Text(
                      'Add Balance',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showpopup(context) {
    Alert(
        context: context,
        title: "Add Balance",
        content: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value!.length <= 0) {
                  return "Balance must not be empty";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                addamount = value;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.money),
                labelText: '₹1000',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Color(0xFF01C5A6),
            splashColor: Color(0xFF01C5A6),
            onPressed: () {
              print(addamount);
              if (addamount == "") {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Add Some Amount')));
              } else
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckRazor(
                          amount: (int.parse(addamount) * 100),
                          email: 'ayushraghuvanshi03@gmail.com',
                          phone: '9305773947'),
                    ));
            },
            child: Text(
              "Add Balance",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
