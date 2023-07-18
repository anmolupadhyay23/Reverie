import 'package:flutter/material.dart';
import 'package:riverie/features/account/screens/yourOrders.dart';
import 'package:riverie/features/account/services/accountServices.dart';
import 'package:riverie/features/account/widgets/accountButton.dart';
import 'package:riverie/features/wishlist/screens/wishlistScreen.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
                text: 'Your Order',
                onTap: () {
                  Navigator.pushNamed(context, YourOrders.routeName);
                }
            ),
            AccountButton(
                text: 'Creative',
                onTap: () {}
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(
                text: 'Log Out',
                onTap: () {
                  AccountServices().logOut(context);
                }
            ),
            AccountButton(
                text: 'Wish List',
                onTap: () {
                  Navigator.pushNamed(context, WishList.routeName);
                }
            )
          ],
        )
      ],
    );
  }
}
