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

class CartServices {

  void removeCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
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
                cart: jsonDecode(res.body)['cart']
            );
            userProvider.setUserFromModel(user);
          })
      ;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}