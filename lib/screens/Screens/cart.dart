import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/screens/Screens/course_bought.dart';
import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/cartCourse.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cartitems = [];

  num totalprice = 0;
  Future<void> getcart() async {
    API api = API();
    api.getCart().then((value) {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
        setState(() {
          cartitems = value;
        });
      }
    });
  }

  bool loading = true;
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        child: _pagebuild(context), inAsyncCall: loading, blur: 0.5);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(screentouch);
  }

  Widget _pagebuild(BuildContext context) {
    return FutureBuilder(
      future: getcart(),
      builder: ((context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 64, right: 16),
          child: Column(
            children: [
              Text(
                'My Cart',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: cartitems.length,
                      itemBuilder: ((context, index) {
                        if (cartitems[0] == 'no courses in cart') {
                          totalprice = 0;
                          return Center(
                            child: Center(
                                child: Text('NO COURSES IN THE CART YET')),
                          );
                        }
                        if (index == 0) {
                          totalprice = 0;
                        }
                        totalprice += cartitems[index]['price'];

                        return CartCourses(
                          // catog: cartitems[index]['category'],
                          // desc: cartitems[index]['short_description'],
                          // edu: cartitems[index]['educator_mail'],
                          edu_name: cartitems[index]['educator_name'],
                          id: cartitems[index]['id'],
                          price: cartitems[index]['price'],
                          rating: cartitems[index]['rating'],
                          thumbnail: cartitems[index]['thumbnail'],
                          topic: cartitems[index]['topic'],
                        );
                        // return Container();
                      }))),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Color(0xFF01C5A6),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            '₹$totalprice',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: (cartitems.isEmpty)
                            ? null
                            : (cartitems[0] == 'no courses in cart')
                                ? null
                                : () {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (cartitems[0] == 'no courses in cart') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Add Something in cart first')));
                                    } else {
                                      API api = API();
                                      api.buyallcourse().then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    CourseBought())));
                                      });
                                    }
                                  },
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 24, right: 24, top: 16, bottom: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: Text(
                                'Checkout',
                                style: TextStyle(color: Colors.black),
                              ),
                            ))),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
