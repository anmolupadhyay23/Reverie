import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/account/screens/accountScreen.dart';
import 'package:riverie/features/cart/screens/cartScreen.dart';
import 'package:riverie/features/home/screens/homeScreen.dart';
import 'package:riverie/provider/user_provider.dart';

import '../features/category/screens/allCategory.dart';

class bottomBar extends StatefulWidget {
  static const String routeName='/actual-home';
  const bottomBar({Key? key}) : super(key: key);

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int _page=0;
  double _bottomBarWidth=25;
  double _bottomBarBorderWidth=3;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
    const AllCategory(),
  ];

  void updatePage(int page) {
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength=context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page==0 ? Colors.black : Colors.black12,
                      width: _bottomBarBorderWidth
                    )
                  )
                ),
                child: const Icon(
                    MdiIcons.home
                ),
              ),
            label: ''
          ),
          // ACCOUNT
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page==1 ? Colors.black : Colors.black12,
                            width: _bottomBarBorderWidth
                        )
                    )
                ),
                child: const Icon(MdiIcons.accountCowboyHatOutline),
              ),
            label: ''
          ),
          // CART
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page==2 ? Colors.black : Colors.black12,
                            width: _bottomBarBorderWidth
                        )
                    )
                ),
                child: Badge(
                  badgeStyle: BadgeStyle(
                    badgeColor: Colors.black38
                  ),
                  badgeContent: Text(
                    userCartLength.toString(),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  position: BadgePosition.topEnd(),
                  showBadge: userCartLength==0
                      ? false
                      : true,

                  child: const Icon(
                      // Icons.shopping_cart_outlined,
                    MdiIcons.cart
                  ),
                ),
              ),
            label: ''
          ),
          // CATEGORY
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page==3 ? Colors.black : Colors.black12,
                            width: _bottomBarBorderWidth
                        )
                    )
                ),
                child: const Icon(Icons.category),
              ),
              label: ''
          ),
        ],
      ),
    );
  }
}
