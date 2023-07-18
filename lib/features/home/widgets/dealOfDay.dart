import 'package:flutter/material.dart';
import 'package:riverie/features/home/services/homeServices.dart';
import 'package:riverie/features/productDetails/screens/productDetailScreen.dart';
import 'package:riverie/widgets/loader.dart';

import '../../../model/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {

  Product? product;
  final HomeServices homeServices=HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dealOfDay();
  }

  void dealOfDay() async {
    product=await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateDetailScreen(){
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product==null
        ? const Loader()
        : product!.name.isEmpty ? const SizedBox()
        : GestureDetector(
      onTap: navigateDetailScreen,
          child: Column(
      children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10,top: 15),
            child: const Text(
                'Best Rated',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Image.network(
              product!.images[0],
            height: 235,
            fit: BoxFit.fitHeight,
          ),
        const SizedBox(height: 10,),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const Text(
                  'Price: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  '₹${product!.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10,),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15,top: 5,right: 40),
            child: Text(
              product!.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)
            ),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: product!.images.map((e)=> Image.network(
                  e,
                  fit: BoxFit.fitHeight,
                  width: 110,
                  height: 110,

                ),
                ).toList(),
              ),
            ),
          ),
          // Container(
          //   alignment: Alignment.topLeft,
          //   padding: const EdgeInsets.only(left: 15,top: 15,bottom: 15),
          //   child: Text(
          //     'See all deals',
          //     style: TextStyle(
          //       color: Colors.black26
          //     ),
          //   ),
          // )
      ],
    ),
        );
  }
}
