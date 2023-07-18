import 'package:flutter/material.dart';
import 'package:riverie/features/account/services/accountServices.dart';
import 'package:riverie/features/account/widgets/singleProduct.dart';
import 'package:riverie/widgets/loader.dart';

import '../../../model/order.dart';
import '../../orderDetails/screens/orderDetailsScreen.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  List<Order>? orders;
  final AccountServices accountServices=AccountServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders=await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders==null
        ? const Loader()
        : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        // DISPLAY ORDERS
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10,top: 20,right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context,index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: orders![index]);
                },
                child: SingleProduct(
                    image: orders![index].products[0].images[0],
                ),
              );
          },
          ),
        )
      ],
    );
  }
}
