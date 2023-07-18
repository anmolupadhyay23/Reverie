import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/cart/screens/cartScreen.dart';
import 'package:riverie/features/wishlist/widgets/customWishListButton.dart';
import 'package:riverie/features/wishlist/widgets/wishlistProduct.dart';
import 'package:riverie/widgets/bottomBar.dart';
import '../../../provider/user_provider.dart';
import '../../cart/widgets/customCartButton.dart';

class WishList extends StatefulWidget {
  static const String routeName='/wishlist';
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    int sum=0;
    user.wishlist.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();
    print(sum);
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
                  'WISHLIST',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   child: GestureDetector(
              //     onTap: () {},
              //       child: Icon(MdiIcons.account)
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: sum==0
          ? Container(
            margin: EdgeInsets.only(left: 80,top: 280,right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NOTING SAVED YET',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Tap the heart icon to save items for later.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: WishListButton(
                    text: 'START SHOPPING',
                    onTap: () {
                      Navigator.pushNamed(context, bottomBar.routeName);
                    },
                    fgColor: Colors.white,
                    bgColor: Colors.black,
                    textSize: 15.0,
                  ),
                )
              ],
            ),
          )
          :SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView.builder(
          itemCount: user.wishlist.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          itemBuilder: (context,index) {
            return WishListProduct(
                index: index
            );
          },
        ),
      )
    );
  }
}
