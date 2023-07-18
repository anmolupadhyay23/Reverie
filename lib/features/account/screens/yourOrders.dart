import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:riverie/features/account/services/accountServices.dart';
import 'package:riverie/features/account/widgets/singleProduct.dart';
import 'package:riverie/widgets/loader.dart';

import '../../../model/order.dart';
import '../widgets/completedOrders.dart';
import '../widgets/yourCurrentOrders.dart';

class YourOrders extends StatefulWidget {
  static const String routeName='/your-orders';
  const YourOrders({Key? key}) : super(key: key);

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient, // Color can be changed from globalVariables
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 42,
                color: Colors.transparent,
                child: Text(
                  'YOUR ORDERS',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                child: GestureDetector(
                    onTap: () {},
                    child: Icon(MdiIcons.account)
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YourCurrentOrders(),
            CompletedOrders(),
          ],
        ),
      ),
    );
  }
}
