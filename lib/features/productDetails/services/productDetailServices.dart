import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/errorHandling.dart';
import '../../../constants/globalVariables.dart';
import '../../../constants/utils.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';
import '../../../provider/user_provider.dart';

class ProductDetailServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id!,
            'rating': rating,
          }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {})
      ;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user=userProvider.user.copyWith(
              cart: jsonDecode(res.body)['cart']
            );
            userProvider.setUserFromModel(user);
            showSnackBar(context, 'Product added to cart');
          })
      ;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToWishList({
    required BuildContext context,
    required Product product,
}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-wishlist'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user=userProvider.user.copyWith(
                wishlist: jsonDecode(res.body)['wishlist']
            );
            userProvider.setUserFromModel(user);
            showSnackBar(context, 'Product added to wishlist');
          })
      ;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}