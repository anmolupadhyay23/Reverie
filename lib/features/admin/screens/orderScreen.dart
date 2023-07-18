import 'package:flutter/material.dart';
import 'package:riverie/features/account/widgets/singleProduct.dart';
import 'package:riverie/features/admin/services/adminServices.dart';
import 'package:riverie/features/orderDetails/screens/orderDetailsScreen.dart';
import 'package:riverie/widgets/loader.dart';
import '../../../model/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List<Order>? orders;
  final AdminServices adminServices=AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders=await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders==null ?  const Loader() : GridView.builder(
      itemCount: orders!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context,index) {
        final orderData=orders![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, OrderDetailsScreen.routeName,arguments: orderData);
          },
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: SingleProduct(
                image: orderData.products[0].images[0],
                ),
                ),
              Text(
                // '\$${orderData.totalPrice.toString()}',
                  'Order Status: ${orderData.status.toString()}'
              )
            ],
          ),
        );
        }
    );
  }
}
