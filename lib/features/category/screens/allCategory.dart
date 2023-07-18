import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/wishlist/screens/wishlistScreen.dart';

import '../../../constants/globalVariables.dart';
import '../../../provider/user_provider.dart';
import '../../customization/screens/customizationScreen.dart';
import '../../home/screens/categoryScreen.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {

  void categoryNavigate(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category);
  }
  
  @override
  Widget build(BuildContext context) {
    final userWishListLength=context.watch<UserProvider>().user.wishlist.length;
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
                  'CATEGORIES',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
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
                  ),
                  SizedBox(width: 15,),
                  // Container(
                  //   color: Colors.transparent,
                  //   height: 42,
                  //   child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.pushNamed(context, CustomizationScreen.routeName);
                  //       },
                  //       child: const Icon(MdiIcons.lightningBolt)
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            shrinkWrap: true,
            itemCount: GlobalVariables.categoryImages.length,
            itemBuilder: (context,index) {
              return GestureDetector(
                onTap: () {
                  categoryNavigate(context, GlobalVariables.categoryImages[index]['title']!);
                },
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Text(
                      GlobalVariables.categoryImages[index]['title']!,
                    )
                  ],
                ),
              );
            }
        ),
      ),
      );
  }
}
