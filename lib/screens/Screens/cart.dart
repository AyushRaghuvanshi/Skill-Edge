import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/cartCourse.dart';
import 'package:skilledge/widgets/courseCard.dart';
import 'package:skilledge/widgets/searchCourse.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cartitems = [];
  Future<void> getcart() async {
    API api = API();
    api.getCart().then((value) {
      setState(() {
        cartitems = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getcart(),
      builder: ((context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 64),
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
                          return Center(
                            child: Center(
                                child: Text('NO COURSES IN THE CART YET')),
                          );
                        }

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
                      })))
            ],
          ),
        );
      }),
    );
  }
}
