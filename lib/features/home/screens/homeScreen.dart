import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/home/widgets/addressBar.dart';
import 'package:riverie/features/home/widgets/carouselImage.dart';
import 'package:riverie/features/home/widgets/category.dart';
import 'package:riverie/features/home/widgets/dealOfDay.dart';
import 'package:riverie/features/home/widgets/topCategories.dart';
import 'package:riverie/features/wishlist/screens/wishlistScreen.dart';
import '../../../provider/user_provider.dart';
import '../../search/screens/searchScreen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName='/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void NavigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
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
                color: Colors.white
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  // margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    // elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: NavigateSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 6
                            ),
                            child: Icon(Icons.search,color: Colors.black, size: 23,),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        // border: const OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(7)
                        //   ),
                        //   borderSide: BorderSide.none
                        // ),
                        // enabledBorder: const OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(
                        //         Radius.circular(7)
                        //     ),
                        //     borderSide: BorderSide(color: Colors.black38,width: 1)
                        // ),
                        hintText: 'Search...',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, WishList.routeName);
                  },
                  child: userWishListLength==0
                      ? const Icon(MdiIcons.heartOutline)
                      : const Icon(
                    MdiIcons.heart,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const[
            AddressBar(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10,),
            // CarouselImage(),
            DealOfDay(),
            // category(),
          ],
        ),
      )
    );
  }
}
