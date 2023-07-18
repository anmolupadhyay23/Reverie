import 'package:flutter/material.dart';
import 'package:riverie/features/home/services/homeServices.dart';
import 'package:riverie/features/productDetails/screens/productDetailScreen.dart';
import '../../../model/product.dart';
import '../../../widgets/loader.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName='/category-screen';
  final String category;
  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<Product>? productList;
  final HomeServices homeServices=HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList=await homeServices.fetchCategoryProducts(context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                // gradient: GlobalVariables.appBarGradient, // Color can be changed from globalVariables
                  color: Colors.white
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 42,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  child: Icon(Icons.category),
                )
              ],
            ),
          ),
        ),
      body: productList==null ? const Loader() : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shopping for  ${widget.category}',
              style: const TextStyle(
                fontSize: 20
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
              itemCount: productList!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  childAspectRatio: 1.4,
                  mainAxisSpacing: 10
                ),
                itemBuilder: (context,index) {
                final product=productList![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                            child: Image.network(product.images[0]),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10,top: 5,right: 50),
                          child: Text(
                              product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
