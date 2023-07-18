import 'package:flutter/material.dart';
import 'package:riverie/features/account/widgets/singleProduct.dart';
import 'package:riverie/features/admin/screens/addProduct.dart';
import 'package:riverie/features/admin/services/adminServices.dart';
import 'package:riverie/widgets/loader.dart';

import '../../../model/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  final AdminServices adminServices=AdminServices();
  List<Product>? products=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products=await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        }
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products==null
        ? const Loader()
        : Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2 // number of item in one row
          ),
          itemBuilder: (context,index) {
            final productData=products![index];
            return Column(
              children: [
                SizedBox(
                  height: 130, // 133 is the limit
                  child: SingleProduct(
                      image: productData.images[0],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                            ),
                          ),
                        ),
                    ),
                    IconButton(
                        onPressed: () => deleteProduct(productData, index),
                        icon: const Icon(Icons.delete_outline)
                    )
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.black26,
                  child: SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black12,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        elevation: 2.5,
        onPressed: navigateToAddProduct,
        tooltip: 'Add a product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
