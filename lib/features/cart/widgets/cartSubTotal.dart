import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverie/provider/user_provider.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    int sum=0;
    user.cart.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Order Amount: ',
            style:
            TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '₹$sum',
            style:
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),

        ]
      ),
    );
  }
}
