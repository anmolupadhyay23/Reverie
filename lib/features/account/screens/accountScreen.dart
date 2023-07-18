import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:riverie/constants/globalVariables.dart';
import 'package:riverie/features/account/widgets/appBarBottom.dart';
import 'package:riverie/features/account/widgets/completedOrders.dart';
import 'package:riverie/features/account/widgets/orders.dart';
import 'package:riverie/features/account/widgets/topButtons.dart';
import 'package:riverie/features/account/widgets/userDetails.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

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
                alignment: Alignment.topLeft,
                // child: Image.asset('assets/riverie.png',width: 120,height: 45,color: Colors.black,),
                child: Text(
                  'Reverie',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    fontSize: 20
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(left: 15,right: 15),
              //   child: Row(
              //     children: [
              //       Padding(
              //           padding: EdgeInsets.only(right: 0),
              //         child: Row(
              //           children: [
              //             SizedBox(width: 20,),
              //             Icon(MdiIcons.bell),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: const[
              // AppBarBottom(),
              // SizedBox(height: 10,),
              // TopButtons(),
              // SizedBox(height: 20,),
              // Orders(),
              // SizedBox(height: 20,),
              // CompletedOrders(),
              SizedBox(height: 10,),
              userDetails()
            ],
          ),
        ),
      ),
    );
  }
}
