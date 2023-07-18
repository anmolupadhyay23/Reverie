import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:riverie/features/home/widgets/addressBar.dart';
import 'package:riverie/features/search/services/searchServices.dart';
import 'package:riverie/features/search/widgets/searchedProduct.dart';
import 'package:riverie/widgets/loader.dart';
import '../../../model/product.dart';
import '../../productDetails/screens/productDetailScreen.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName='/search-screen';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Product>? products;
  final SearchServices searchServices=SearchServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchProducts();
  }

  fetchSearchProducts() async {
    products=await searchServices.fetchSearchProducts(
        context: context,
        searchQuery: widget.searchQuery
    );
    setState(() {});
  }

  void NavigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          //     borderRadius: BorderRadius.all(
                          //         Radius.circular(7)
                          //     ),
                          //     borderSide: BorderSide.none
                          // ),
                          // enabledBorder: const OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(
                          //         Radius.circular(7)
                          //     ),
                          //     borderSide: BorderSide(color: Colors.black38,width: 1)
                          // ),
                          hintText: 'Search item',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14
                          )
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   child: const Icon(MdiIcons.heart),
              // ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   child: const Icon(MdiIcons.cart),
              // )
            ],
          ),
        ),
      ),
            body: products==null
                ? const Loader()
                : Column(
              children: [
                const AddressBar(),
                const SizedBox(height: 10,),
                Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
                        itemBuilder: (context,index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: products![index]);
                            },
                              child: SearchedProduct(
                                  product: products![index]
                              )
                          );
                        }
                    )
                )
              ],
            )
          );
  }
}
