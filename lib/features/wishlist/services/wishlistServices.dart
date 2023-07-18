import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../constants/errorHandling.dart';
import '../../../constants/globalVariables.dart';
import '../../../constants/utils.dart';
import '../../../model/product.dart';
import '../../../model/user.dart';
import '../../../provider/user_provider.dart';
import 'package:http/http.dart' as http;

class WishlistServices {

  // ADD TO WISHLIST
  void addToWishlist({
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
                cart: jsonDecode(res.body)['wishlist']
            );
            userProvider.setUserFromModel(user);
          })
      ;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // REMOVE WISHLIST
  void removeWishlist({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-wishlist/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user=userProvider.user.copyWith(
                wishlist: jsonDecode(res.body)['wishlist']
            );
            userProvider.setUserFromModel(user);
            showSnackBar(context, 'Removed from wishlist');
          })
      ;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}