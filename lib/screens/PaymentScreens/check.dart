import 'package:flutter/material.dart';
import 'package:skilledge/screens/PaymentScreens/failed.dart';
import 'package:skilledge/screens/PaymentScreens/success.dart';
import 'package:skilledge/services/api_services.dart';

import 'package:skilledge/services/razorpay.dart';

class CheckRazor extends StatefulWidget {
  const CheckRazor({super.key, this.amount, this.email, this.phone});
  final amount;
  final email;
  final phone;
  @override
  _CheckRazorState createState() => _CheckRazorState();
}

class _CheckRazorState extends State<CheckRazor> {
  Razorpay _razorpay = Razorpay();
  var options;

  bool first = true;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    API api = API();
    await api.addbalancewallet(widget.amount, response.paymentId!);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
          response: response,
        ),
      ),
    );

    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => FailedPage(
    //       response: response,
    //     ),
    //   ),
    // );

    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options = {
      'key':
          "rzp_test_0cvLsWdMVglYcU", // Enter the Key ID generated from the Dashboard
      'amount': widget.amount, //in the smallest currency sub-unit.
      'name': 'SkillEdge',
      'currency': "INR",
      'theme.color': "#01C5A6",
      'buttontext': "Pay with Razorpay",
      'description': 'Buy your Course',
      'prefill': {
        'contact': widget.phone.toString(),
        'email': widget.email.toString(),
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            first = false;
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
