import 'package:flutter/material.dart';
import 'package:riverie/features/account/widgets/singleProduct.dart';

import '../../../model/order.dart';
import '../../../widgets/loader.dart';
import '../../orderDetails/screens/orderDetailsScreen.dart';
import '../services/accountServices.dart';

class YourCurrentOrders extends StatefulWidget {
  const YourCurrentOrders({Key? key}) : super(key: key);

  @override
  State<YourCurrentOrders> createState() => _YourCurrentOrdersState();
}

class _YourCurrentOrdersState extends State<YourCurrentOrders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyOrders();
  }

  void fetchMyOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  'Current Orders',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                alignment: Alignment.topLeft,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.only(left: 15),
              //       child: const Text(
              //         'Completed Orders',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.only(right: 15),
              //       child: const Text(
              //         'See all',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // DISPLAY COMPLETED ORDERS
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailsScreen.routeName,
                            arguments: orders![index]);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleProduct(
                              image: orders![index].products[0].images[0],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
