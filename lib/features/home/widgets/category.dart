import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../productDetails/screens/productDetailScreen.dart';
import '../services/homeServices.dart';

class category extends StatefulWidget {
  const category({Key? key}) : super(key: key);

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {

  List<Product>? productList;
  final HomeServices homeServices=HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList=await homeServices.fetchCategoryProducts(context: context, category: 'Jeans');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10,top: 15),
          child: const Text(
            'T-shirts',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15),
              itemCount: productList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (context,index) {
                final product=productList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                              product.images[0]
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}
