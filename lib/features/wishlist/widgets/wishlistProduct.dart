import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:riverie/constants/utils.dart';
import 'package:riverie/features/productDetails/services/productDetailServices.dart';
import 'package:riverie/widgets/addToCartButton.dart';

import '../../../model/product.dart';
import '../../../provider/user_provider.dart';
import '../services/wishlistServices.dart';

class WishListProduct extends StatefulWidget {
  final int index;
  const WishListProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<WishListProduct> createState() => _WishListProductState();
}

class _WishListProductState extends State<WishListProduct> {

  @override
  Widget build(BuildContext context) {

    final productWishList=context.watch<UserProvider>().user.wishlist[widget.index];
    final product=Product.fromMap(productWishList['product']);

    final WishlistServices wishlistServices=WishlistServices();

    final ProductDetailServices productDetailServices=ProductDetailServices();

    void removeWishlist(Product product) {
      wishlistServices.removeWishlist(context: context, product: product);
    }

    void addToCart(Product product) {
      productDetailServices.addToCart(context: context, product: product);
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            // color: Colors.green,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.images[0],
                      fit: BoxFit.fitWidth,
                      height: 150,
                      width: 105,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            '₹${product.price}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.description,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 70,),
                    Container(
                      margin: EdgeInsets.only(top: 10,right: 10),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          removeWishlist(product);
                        },
                        child: Icon(
                          MdiIcons.heartBroken
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: AddToCartButton(
                      text: 'Add to cart',
                      onTap: () {
                        addToCart(product);
                      },
                      fgColor: Colors.white,
                      bgColor: Colors.black,
                      textSize: 12,
                    icon: MdiIcons.cart,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 2,
            child: Container(
              color: Colors.black26,
            ),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
