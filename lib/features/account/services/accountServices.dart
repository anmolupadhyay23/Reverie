import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:riverie/features/auth/screens/authScreen.dart';
import 'package:riverie/model/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/errorHandling.dart';
import '../../../constants/globalVariables.dart';
import '../../../constants/utils.dart';
import '../../../model/product.dart';
import '../../../provider/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList=[];
    try{
      http.Response res=await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {
        for(int i=0;i<jsonDecode(res.body).length;i++){
          orderList.add(
            Order.fromJson(jsonEncode(jsonDecode(res.body)[i],
            ),
            ),
          );
        }
      });
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    Product product= Product(name: '', description: '', quantity: 0, images: [], category: '', price: 0);
    try{
      http.Response res=await http.get(
        Uri.parse('$uri/api/deal-of-the-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {
        product=Product.fromJson(res.body);
      });
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }

  // LOGGING USER OUT
  void logOut(BuildContext context) async {
    try{
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false);
    } catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // FETCH COMPLETED ORDERS
  Future<List<Order>> fetchCompletedOrders({
    required BuildContext context,
  }) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    List<Order> orderList=[];
    try{
      http.Response res=await http.get(
        Uri.parse('$uri/api/orders-completed/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {
        for(int i=0;i<jsonDecode(res.body).length;i++){
          orderList.add(
            Order.fromJson(jsonEncode(jsonDecode(res.body)[i],
            ),
            ),
          );
        }
      });
    } catch(e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }
}