import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverie/constants/errorHandling.dart';
import 'package:riverie/constants/globalVariables.dart';
import 'package:riverie/constants/utils.dart';
import 'package:riverie/model/product.dart';
import '../../../model/user.dart';
import 'package:http/http.dart' as http;
import '../../../provider/user_provider.dart';

class AddressServices {
  void SaveUserAddress({
    required BuildContext context,
    required String address
  }) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res=await http.post(
          Uri.parse('$uri/api/save-user-address'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode(
              {'address': address,}
          )
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        User user=userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
        );
        userProvider.setUserFromModel(user);
      });

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // FETCH PRODUCTS
  void placeOrder({required BuildContext context, required String address, required double total}) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res=await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': total,
        })
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(context, 'Your order has been placed');
        User user=userProvider.user.copyWith(
          cart: [],
        );
        userProvider.setUserFromModel(user);
      });
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // DELETE PRODUCT
  void deleteProduct(
      {required BuildContext context,
        required Product product,
        required VoidCallback onSuccess,}) async {
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
      http.Response res=await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          }
      );

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }
}