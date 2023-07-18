import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/account/widgets/completedOrders.dart';

import '../../../provider/user_provider.dart';
import '../../wishlist/screens/wishlistScreen.dart';
import '../screens/yourOrders.dart';
import '../services/accountServices.dart';

class userDetails extends StatelessWidget {
  const userDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.3,
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://robohash.org/${user.name}'),
            backgroundColor: Colors.grey,
            radius: 80,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        Text(
          user.email,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, YourOrders.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Your orders',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    MdiIcons.tshirtV,
                    size: 20,
                  ),
                )
              ],
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(8.0),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 30,right: 30),
        //   child: TextButton(
        //     onPressed: () {
        //       CompletedOrders();
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Container(
        //           margin: const EdgeInsets.only(left: 10),
        //           child: Text(
        //             'Completed orders',
        //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //         Container(
        //           margin: const EdgeInsets.only(right: 10),
        //           child: const Icon(
        //             MdiIcons.tshirtVOutline,
        //             size: 20,
        //           ),
        //         )
        //       ],
        //     ),
        //     style: TextButton.styleFrom(
        //       foregroundColor: Colors.white,
        //       backgroundColor: Colors.black,
        //       padding: const EdgeInsets.all(8.0),
        //       shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, WishList.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Wish List',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    MdiIcons.heart,
                    size: 20,
                  ),
                )
              ],
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(8.0),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: TextButton(
            onPressed: () {
              AccountServices().logOut(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    MdiIcons.logout,
                    size: 20,
                  ),
                )
              ],
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(8.0),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          child: const Text(
            'v 1.0.0',
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
