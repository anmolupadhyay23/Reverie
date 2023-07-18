// CART SCREEN

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/address/screens/addressScreen.dart';
import 'package:riverie/features/cart/widgets/cartSubTotal.dart';
import 'package:riverie/features/cart/widgets/customCartButton.dart';
import 'package:riverie/features/home/widgets/addressBar.dart';
import 'package:riverie/features/wishlist/screens/wishlistScreen.dart';
import 'package:riverie/widgets/bottomBar.dart';
import 'package:riverie/widgets/customButton.dart';

import '../../../provider/user_provider.dart';
import '../../search/screens/searchScreen.dart';
import '../widgets/cartProduct.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final bottomBar BottomBar=bottomBar();

  void NavigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  void NavigateAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    final userWishListLength=context.watch<UserProvider>().user.wishlist.length;
    int sum=0;
    user.cart.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();
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
                child: const Text(
                  'SHOPPING BAG',
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
                  onTap: () {
                    Navigator.pushNamed(context, WishList.routeName);
                  },
                    child: userWishListLength==0
                        ? const Icon(MdiIcons.heartOutline)
                        : const Icon(MdiIcons.heart)
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: sum==0
            ? Column(
          children: [
            const AddressBar(),
            Container(
              margin: EdgeInsets.only(top: 300),
              child: Column(
                children: [
                  const Text(
                      'YOUR CART IS EMPTY',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Why is that? Let\'s get creative',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: cartButton(
                        text: 'BROWSE',
                        onTap: () {
                          // To enhance it we can instead switch page numbers so that it looks clean
                          setState(() {
                            Navigator.popAndPushNamed(context, bottomBar.routeName);
                          });
                          // setState(() {
                          //   _pa
                          // });
                        },
                        fgColor: Colors.white,
                        bgColor: Colors.black,
                      textSize: 15.0,
                    ),
                  )
                ],
              ),
            )
          ],
        )
            :Column(
          children: [
            const AddressBar(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: customButton(
                  text: 'Proceed to Buy ${user.cart.length} item(s)',
                  onTap: (){
                    NavigateAddress(sum);
                  },
                  fgColor: Colors.white,
                  bgColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: user.cart.length,
                itemBuilder: (context,index) {
                  return CartProduct(
                    index: index,
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
