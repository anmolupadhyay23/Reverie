import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/productDetails/services/productDetailServices.dart';
import 'package:riverie/model/product.dart';
import 'package:riverie/widgets/customButton.dart';
import 'package:riverie/widgets/stars.dart';
import '../../../provider/user_provider.dart';
import '../../search/screens/searchScreen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName='/product-details-screen';
  final Product product;
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductDetailServices productDetailServices=ProductDetailServices();
  double avgRating=0;
  double myRating=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating=0;
    for(int i=0;i<widget.product.rating!.length;i++){
      totalRating+=widget.product.rating![i].rating;
      if(widget.product.rating![i].userId==Provider.of<UserProvider>(context,listen: false).user.id) {
        myRating=widget.product.rating![i].rating;
      }
    }

    if(totalRating!=0){
      avgRating=totalRating/widget.product.rating!.length;
    }
  }

  void NavigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  void addToCart() {
    productDetailServices.addToCart(context: context, product: widget.product);
  }

  void addToWishlist() {
    productDetailServices.addToWishList(context: context, product: widget.product);
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
              //   child: const Icon(Icons.mic,color: Colors.black,size: 25,),
              // )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(
                      rating: avgRating,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
          child: Container(
                // width: MediaQuery.of(context).size.width,
                // child: customButton(
                //     text: 'Wishlist',
                //     onTap: addToWishlist,
                //     fgColor: Colors.white,
                //     bgColor: Colors.black87
                // ),
            child: GestureDetector(
              onTap: () {
                addToWishlist();
              },
              child: userWishListLength==0
                  ? const Icon(MdiIcons.heartOutline)
                  : const Icon(
                    MdiIcons.heart,
                  )
            ),
          ),
        ),
              ],
            ),
      CarouselSlider(
        items: widget.product.images.map((i) {
          return Builder(
              builder: (BuildContext context) => Image.network(
                i,
                fit: BoxFit.contain,
                height: 200,
              )
          );
        }).toList(),
        options: CarouselOptions(
            viewportFraction: 1,
            height: 300
        ),
      ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
                padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                    text: '₹${widget.product.price}',
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     child: customButton(
            //         text: 'Buy Now',
            //         onTap: () {},
            //         fgColor: Colors.white,
            //         bgColor: Colors.black87
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: customButton(
                    text: 'Add to Cart',
                    onTap: addToCart,
                    fgColor: Colors.white,
                    bgColor: Colors.black87
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     child: customButton(
            //         text: 'Wishlist',
            //         onTap: addToWishlist,
            //         fgColor: Colors.white,
            //         bgColor: Colors.black87
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              onRatingUpdate: (rating) {
                productDetailServices.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating
                );
              },
              itemBuilder: (context, _)=>const Icon(
                Icons.star,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
